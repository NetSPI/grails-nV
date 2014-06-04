databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401899841549-1") {
		addColumn(tableName: "user") {
			column(name: "ssn", type: "varchar(11)")
		}
	}
}
