databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401741597725-1") {
		dropNotNullConstraint(columnDataType: "varchar(2000)", columnName: "parameters", tableName: "log")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401741597725-2") {
		dropNotNullConstraint(columnDataType: "varchar(2000)", columnName: "referer", tableName: "log")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401741597725-3") {
		dropNotNullConstraint(columnDataType: "varchar(2000)", columnName: "useragent", tableName: "log")
	}
}
