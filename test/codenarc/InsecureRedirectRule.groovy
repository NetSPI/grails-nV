package com.nvisium.rule.security

import org.codehaus.groovy.ast.ClassNode
import org.codehaus.groovy.ast.InnerClassNode
import org.codehaus.groovy.ast.expr.ConstantExpression
import org.codehaus.groovy.ast.expr.DeclarationExpression
import org.codehaus.groovy.ast.expr.MethodCallExpression
import org.codehaus.groovy.ast.expr.NamedArgumentListExpression
import org.codehaus.groovy.ast.expr.VariableExpression
import org.codehaus.groovy.ast.stmt.BlockStatement
import org.codenarc.rule.AbstractAstVisitor
import org.codenarc.rule.AbstractAstVisitorRule
import org.codenarc.util.AstUtil
import org.codehaus.groovy.ast.stmt.ForStatement

/**
 * Rule that checks for instances of insecure redirects within Grails code.
 * Based on the UnusedVariableRule by Chris Mair and Hamlet D'Arcy
 *
 * @author Chris Mair
 * @author Hamlet D'Arcy
*/
class InsecureRedirectRule extends AbstractAstVisitorRule {
    String name = 'InsecureRedirect'
    int priority = 2
    String description = "Checks for redirects that are tainted by user parameters"
    Class astVisitorClass = InsecureRedirectRule2AstVisitor
}

class InsecureRedirectRule2AstVisitor extends AbstractAstVisitor  {

    private final variablesByBlockScope = [] as Stack
    private variablesInCurrentBlockScope = []

    void visitDeclarationExpression(DeclarationExpression declarationExpression) {
        if (isFirstVisit(declarationExpression)) {
            def varExpressions = AstUtil.getVariableExpressions(declarationExpression)
            varExpressions.each { varExpression ->
                if (declarationExpression.getRightExpression().getText().contains("params")) {
                    variablesInCurrentBlockScope << varExpression
                }

                if (declarationExpression.getRightExpression().getText() in variablesInCurrentBlockScope) {
                    variablesInCurrentBlockScope << varExpression
                }
            }
        }
        super.visitDeclarationExpression(declarationExpression)
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
            if (call.getMethod().getText() == "redirect" && call.arguments && call.arguments.expressions) {
                def exp = call.getArguments().first()
                if (exp && exp instanceof NamedArgumentListExpression) {
                    for (x in exp.getMapEntryExpressions()) {
                        if (x.getKeyExpression().getText() == "url") {
                            for (varInBlockScope in variablesInCurrentBlockScope) {
                                if (x.getValueExpression().getText().contains(varInBlockScope.variable)) {
                                    addViolation(call, "Insecure redirect. Specify redirects using controller and action parameters, not based on user parameters (${varInBlockScope.variable}) [Tainted: ${variablesInCurrentBlockScope}]")
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