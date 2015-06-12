package com.nvisium.rule.security

import org.codehaus.groovy.ast.ClassNode
import org.codehaus.groovy.ast.InnerClassNode
import org.codehaus.groovy.ast.expr.BinaryExpression
import org.codehaus.groovy.ast.expr.ConstantExpression
import org.codehaus.groovy.ast.expr.DeclarationExpression
import org.codehaus.groovy.ast.expr.MethodCallExpression
import org.codehaus.groovy.ast.expr.GStringExpression
import org.codehaus.groovy.ast.expr.VariableExpression
import org.codehaus.groovy.ast.stmt.BlockStatement
import org.codenarc.rule.AbstractAstVisitor
import org.codenarc.rule.AbstractAstVisitorRule
import org.codenarc.util.AstUtil
import org.codehaus.groovy.ast.stmt.ForStatement

/**
 * Rule that checks for instances of insecure SQL/HQL queries within Grails code.
 * Based on the UnusedVariableRule by Chris Mair and Hamlet D'Arcy
 *
 * @author Cyrus Malekpour
 * @author Chris Mair
 * @author Hamlet D'Arcy
*/
class InscureGORMQueryRule extends AbstractAstVisitorRule {
    String name = 'InscureGORMQueryRule'
    int priority = 2
    String description = "Checks for SQL/HQL queries that are tainted by user parameters"
    Class astVisitorClass = InscureGORMQueryRuleAstVisitor
}

class InscureGORMQueryRuleAstVisitor extends AbstractAstVisitor  {

    private final variablesByBlockScope = [] as Stack
    private variablesInCurrentBlockScope = []
    private vulnerableMethods = ["find", "findAll", "executeQuery", "executeUpdate"]

    void visitBinaryExpression(BinaryExpression binaryExpression) {
        if (isFirstVisit(binaryExpression)) {
            if (AstUtil.isBinaryExpressionType(binaryExpression, "=")) {
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
        super.visitBinaryExpression(binaryExpression)
    }

    void visitBlockStatement(BlockStatement block) {
        variablesByBlockScope.push(variablesInCurrentBlockScope)
        super.visitBlockStatement(block)
        variablesByBlockScope.pop()
        variablesInCurrentBlockScope = variablesByBlockScope.empty ? [] : variablesByBlockScope.peek()
    }

    @Override
    void visitMethodCallExpression(MethodCallExpression call) {
        if (isFirstVisit(call)) {
            if (vulnerableMethods.contains(call.getMethod().getText()) && call.arguments && call.arguments.expressions) {
                def exp = call.getArguments().first()
                if (exp && exp instanceof GStringExpression) {
                    if (!exp.isConstantString()) {
                        for (variable in exp.getValues()) {
                            if (variable.getText().contains("params")) {
                                addViolation(call, "Insecure SQL/HQL query. Run queries using the GORM, not with direct query concatenation (params)")
                            } else {
                                variablesInCurrentBlockScope.each {
                                    if (variable.getText() == it) {
                                        addViolation(call, "Insecure SQL/HQL query. Run queries using the GORM, not with direct query concatenation (${it.toString()})")
                                    }
                                }
                            }
                        }             
                    }
                }
            }
        }
        super.visitMethodCallExpression(call)
    }
}