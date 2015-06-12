ruleset {
    description 'CodeNarc secure ruleset'

	rule("file:test/codenarc/InsecureRedirectRule.groovy")
	rule("file:test/codenarc/InsecureHashFunctionRule.groovy")
	rule("file:test/codenarc/InscureGORMQueryRule.groovy")
	rule("file:test/codenarc/InsecureMassAssignmentRule.groovy")
}