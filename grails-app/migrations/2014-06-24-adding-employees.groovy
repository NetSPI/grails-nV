databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1403633657074-1") {
		addColumn(tableName: "user") {
			column(name: "employer_id", type: "bigint")
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1403633657074-2") {
		addForeignKeyConstraint(baseColumnNames: "employer_id", baseTableName: "user", constraintName: "FK_ggbcixcrmm7q2anlgt4jm9htm", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "company", referencesUniqueColumn: "false")
	}
}
