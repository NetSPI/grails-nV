databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401727222343-1") {
		addColumn(tableName: "user") {
			column(name: "fullname", type: "varchar(600)") {
				constraints(nullable: "false")
			}
		}
	}
}
