databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401734778357-1") {
		createTable(tableName: "log") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "logPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "ip", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "page", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "parameters", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "referer", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "useragent", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}
}
