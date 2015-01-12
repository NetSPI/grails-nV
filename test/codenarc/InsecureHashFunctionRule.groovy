package org.codenarc.rule.grails

import org.codenarc.rule.AbstractAstVisitorRule
import org.codenarc.rule.AbstractAstVisitor
import org.codehaus.groovy.ast.expr.MethodCallExpression

class InsecureHashFunctionRule extends AbstractAstVisitorRule {
    String name = 'InsecureHashFunctionRule'
    int priority = 2
    Class astVisitorClass = InsecureHashFunctionRuleAstVisitor
}

@SuppressWarnings('NestedBlockDepth')
class InsecureHashFunctionRuleAstVisitor extends AbstractAstVisitor {

    @Override
    void visitMethodCallExpression(MethodCallExpression call) {
        def methods = ["encodeAsMD5Bytes", "encodeAsMD5", "encodeAsSHA1", "encodeAsSHA1Bytes", "encodeAsSHA256", "encodeAsSHA256Bytes"]
        if (isFirstVisit(call) && methods.contains(call.getMethod().getText())) {
            addViolation(call, "Possible insecure hash function. This function is a message digest, not a password hash")
        }
        super.visitMethodCallExpression(call)
    }

}