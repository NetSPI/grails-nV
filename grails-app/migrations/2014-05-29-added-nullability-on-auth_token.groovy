databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401375915691-1") {
		modifyDataType(columnName: "AUTH_TOKEN", newDataType: "varchar(30)", tableName: "USER")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401375915691-2") {
		dropNotNullConstraint(columnDataType: "varchar(30)", columnName: "AUTH_TOKEN", tableName: "USER")
	}
}
