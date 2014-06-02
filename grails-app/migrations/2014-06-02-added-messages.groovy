databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401722600945-1") {
		createTable(tableName: "message") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "messagePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "author_id", type: "integer") {
				constraints(nullable: "false")
			}

			column(name: "body", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "recipient_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "subject", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401722600945-3") {
		createIndex(indexName: "FK_60b0338jqfujfk48rlpwro1cj", tableName: "message") {
			column(name: "recipient_id")
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401722600945-2") {
		addForeignKeyConstraint(baseColumnNames: "recipient_id", baseTableName: "message", constraintName: "FK_60b0338jqfujfk48rlpwro1cj", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}
}
