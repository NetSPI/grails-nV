databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401378377984-1") {
		addColumn(tableName: "user") {
			column(name: "forgot_token", type: "varchar(30)")
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401378377984-2") {
		addColumn(tableName: "user") {
			column(name: "verify_token", type: "varchar(30)")
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401378377984-3") {
		dropColumn(columnName: "AUTH_TOKEN", tableName: "USER")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401378377984-4") {
		dropColumn(columnName: "VERIFIED", tableName: "USER")
	}
}
