databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401738106169-1") {
		addColumn(tableName: "job_listing") {
			column(name: "howtoapply", type: "varchar(3000)")
		}
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401738106169-2") {
		addColumn(tableName: "job_listing") {
			column(name: "requirements", type: "varchar(3000)")
		}
	}
}
