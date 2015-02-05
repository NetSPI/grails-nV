ruleset {
    description 'CodeNarc secure ruleset'

	rule("file:test/codenarc/InsecureRedirectRule.groovy")
	rule("file:test/codenarc/InsecureRedirectRule2.groovy")
	rule("file:test/codenarc/InsecureHashFunctionRule.groovy")
}