package com.nvisium.rule.security

import org.codehaus.groovy.ast.expr.BinaryExpression
import org.codehaus.groovy.ast.expr.DeclarationExpression
import org.codehaus.groovy.ast.expr.MethodCallExpression
import org.codehaus.groovy.ast.expr.PropertyExpression
import org.codehaus.groovy.ast.expr.VariableExpression
import org.codehaus.groovy.ast.stmt.BlockStatement
import org.codenarc.rule.AbstractAstVisitor
import org.codenarc.rule.AbstractAstVisitorRule
import org.codenarc.util.AstUtil

/**
 * Rule that checks for mass assignment of GORM objects
 * Based on the UnusedVariableRule by Chris Mair and Hamlet D'Arcy,
 * and the GrailsMassAssignmentRule by Brian Soby.
 *
 * @author Cyrus Malekpour
 * @author Chris Mair
 * @author Hamlet D'Arcy
 * @author Brian Soby
*/
class InsecureMassAssignmentRule extends AbstractAstVisitorRule {
    String name = 'InsecureMassAssignmentRule'
    int priority = 2
    String description = "Checks for mass assignment of GORM objects"
    Class astVisitorClass = InsecureMassAssignmentRuleAstVisitor
}

class InsecureMassAssignmentRuleAstVisitor extends AbstractAstVisitor  {

    private final variablesByBlockScope = [] as Stack
    private variablesInCurrentBlockScope = []

    void visitBinaryExpression(BinaryExpression binaryExpression) {
        if (isFirstVisit(binaryExpression)) {
            if (AstUtil.isBinaryExpressionType(binaryExpression, "=")) {

                def shouldScan = true
                /* Check if this is actually mass assignment or just tainting a variable */
                if (binaryExpression.getLeftExpression() instanceof PropertyExpression) {
                    if (binaryExpression.getLeftExpression().getProperty().getText() == 'properties' &&
                        binaryExpression.getRightExpression() instanceof VariableExpression) {
                        def variable = binaryExpression.getRightExpression().getName()
                        if (variable == "params") {
                            addViolation(binaryExpression, "Insecure Mass Assignment. Do not directly assign to object properties from user input (params)")
                        } else {
                            variablesInCurrentBlockScope.each {
                                if (variable == it) {
                                    addViolation(binaryExpression, "Insecure Mass Assignment. Do not directly assign to object properties from user input (${it.toString()})")
                                }
                            }
                        }
                        shouldScan = false
                    }
                }

                if (shouldScan) {
                    if (binaryExpression.getRightExpression().getText().contains("params")) {
                        variablesInCurrentBlockScope.add(binaryExpression.getLeftExpression().getText())
                    } else {
                        def updateList = []
                        variablesInCurrentBlockScope.each {
                            if (binaryExpression.getRightExpression().getText().contains(it)) {
                                updateList.add(binaryExpression.getLeftExpression().getText())
                            }
                        }
                        variablesInCurrentBlockScope.addAll(updateList)
                        variablesInCurrentBlockScope = variablesInCurrentBlockScope.unique()
                    }
                }
            }
        }
        super.visitBinaryExpression(binaryExpression)
    }

    void visitBlockStatement(BlockStatement block) {
        variablesByBlockScope.push(variablesInCurrentBlockScope)
        super.visitBlockStatement(block)
        variablesByBlockScope.pop()
        variablesInCurrentBlockScope = variablesByBlockScope.empty ? [] : variablesByBlockScope.peek()
    }

}