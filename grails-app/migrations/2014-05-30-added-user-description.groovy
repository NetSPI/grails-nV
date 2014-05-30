databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401462839016-1") {
		addColumn(tableName: "user") {
			column(name: "description", type: "varchar(3000)")
		}
	}
}
