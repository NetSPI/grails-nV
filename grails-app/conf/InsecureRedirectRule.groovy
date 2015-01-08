package org.codenarc.rule.grails

import org.codenarc.rule.AbstractAstVisitorRule
import org.codenarc.rule.AbstractAstVisitor
import org.codehaus.groovy.ast.expr.NamedArgumentListExpression
import org.codehaus.groovy.ast.expr.MethodCallExpression
import org.codehaus.groovy.ast.expr.ConstantExpression

class InsecureRedirectRule extends AbstractAstVisitorRule {
    String name = 'InsecureRedirectRule'
    int priority = 2
    Class astVisitorClass = InsecureRedirectRuleAstVisitor
}

@SuppressWarnings('NestedBlockDepth')
class InsecureRedirectRuleAstVisitor extends AbstractAstVisitor {

    @Override
    void visitMethodCallExpression(MethodCallExpression call) {
        if (isFirstVisit(call)) {
            if (call.getMethod().getText() == "redirect" && call.arguments && call.arguments.expressions) {
                def exp = call.getArguments().first()
                if (exp instanceof NamedArgumentListExpression) {
                    for (x in exp.getMapEntryExpressions()) {
                        if (x.getKeyExpression().getText() == "url") {
                            if ( !(x.getValueExpression() instanceof ConstantExpression) ) {
                                addViolation(call, "Insecure redirect. Specify redirects using controller and action parameters")
                            }
                        }
                    }
                }
            }
        }
        super.visitMethodCallExpression(call)
    }

}