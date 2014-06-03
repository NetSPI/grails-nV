databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401819439490-1") {
		addColumn(tableName: "user") {
			column(name: "reset_token", type: "varchar(30)")
		}
	}
}
