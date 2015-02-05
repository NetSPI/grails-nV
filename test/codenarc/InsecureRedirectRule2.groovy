/*
 * Copyright 2009 the original author or authors.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.codenarc.rule.security

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
import org.codenarc.source.SourceCode
import org.codenarc.util.AstUtil
import org.codehaus.groovy.ast.stmt.ForStatement

/**
 * Rule that checks for instances of insecure redirects within Grails code
 *
 * @author Chris Mair
 * @author Hamlet D'Arcy
*/
class InsecureRedirectRule2 extends AbstractAstVisitorRule {
    String name = 'InsecureRedirect2'
    int priority = 2
    String ignoreVariableNames
    Class astVisitorClass = InsecureRedirectRule2AstVisitor
}

class InsecureRedirectRule2AstVisitor extends AbstractAstVisitor  {

    private final variablesByBlockScope = [] as Stack
    private variablesInCurrentBlockScope

    void visitDeclarationExpression(DeclarationExpression declarationExpression) {
        if (isFirstVisit(declarationExpression)) {
            def varExpressions = AstUtil.getVariableExpressions(declarationExpression)
            varExpressions.each { varExpression ->
                if (declarationExpression.getRightExpression().getText().contains("params")) {
                    variablesInCurrentBlockScope[varExpression] = false
                }

                for (varInBlockScope in variablesInCurrentBlockScope.keySet()) {
                    if (declarationExpression.getRightExpression().getText() ==varInBlockScope.variable) {
                        variablesInCurrentBlockScope[varExpression] = false
                    }
                }
            }
        }
        super.visitDeclarationExpression(declarationExpression)
    }

    void visitBlockStatement(BlockStatement block) {
        beforeBlock()
        super.visitBlockStatement(block)
        afterBlock()
    }

    @Override
    void visitForLoop(ForStatement forLoop) {
        beforeBlock()
        super.visitForLoop(forLoop)
        afterBlock()
    }

    private beforeBlock() {
        variablesInCurrentBlockScope = [:]
        variablesByBlockScope.push(variablesInCurrentBlockScope)
    }

    private afterBlock() {
        variablesByBlockScope.pop()
        variablesInCurrentBlockScope = variablesByBlockScope.empty() ? null : variablesByBlockScope.peek()
    }

    @Override
    void visitMethodCallExpression(MethodCallExpression call) {
        if (isFirstVisit(call)) {
            if (call.getMethod().getText() == "redirect" && call.arguments && call.arguments.expressions) {
                def exp = call.getArguments().first()
                if (exp && exp instanceof NamedArgumentListExpression) {
                    for (x in exp.getMapEntryExpressions()) {
                        if (x.getKeyExpression().getText() == "url") {
                            for (varInBlockScope in variablesInCurrentBlockScope.keySet()) {
                                if ( !(x.getValueExpression() instanceof ConstantExpression) && (x.getValueExpression().getText().contains(varInBlockScope.variable)) ) {
                                    addViolation(call, "Insecure redirect. Specify redirects using controller and action parameters, not based on user parameters (${varInBlockScope.variable})")
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