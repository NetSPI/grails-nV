databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401806465151-1") {
		addColumn(tableName: "user") {
			column(name: "accesslevel", type: "integer") {
				constraints(nullable: "false")
			}
		}
	}
}
