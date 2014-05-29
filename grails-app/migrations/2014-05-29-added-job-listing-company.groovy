databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401394933211-1") {
		createTable(tableName: "company") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "companyPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "name", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "website", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401394933211-2") {
		addColumn(tableName: "job_listing") {
			column(name: "company_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401394933211-3") {
		addColumn(tableName: "job_listing") {
			column(name: "fulltime", type: "bit") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401394933211-4") {
		addColumn(tableName: "job_listing") {
			column(name: "location", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401394933211-5") {
		addColumn(tableName: "job_listing") {
			column(name: "startdate", type: "datetime") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401394933211-7") {
		createIndex(indexName: "FK_hw77dwjghu9m2i9ndkkraynpu", tableName: "job_listing") {
			column(name: "company_id")
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401394933211-6") {
		addForeignKeyConstraint(baseColumnNames: "company_id", baseTableName: "job_listing", constraintName: "FK_hw77dwjghu9m2i9ndkkraynpu", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "company", referencesUniqueColumn: "false")
	}
}
