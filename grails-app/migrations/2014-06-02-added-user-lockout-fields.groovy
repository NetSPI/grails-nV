databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401817098138-1") {
		addColumn(tableName: "user") {
			column(name: "attempts", type: "integer") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401817098138-2") {
		addColumn(tableName: "user") {
			column(name: "latest_attempt", type: "datetime")
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401817098138-3") {
		addColumn(tableName: "user") {
			column(name: "original_attempt", type: "datetime")
		}
	}
}
