databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401479283852-1") {
		addColumn(tableName: "user") {
			column(name: "resume", type: "varchar(255)")
		}
	}
}
