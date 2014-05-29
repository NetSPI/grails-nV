databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401397474888-1") {
		modifyDataType(columnName: "CREATED_AT", newDataType: "datetime", tableName: "USER")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401397474888-2") {
		dropNotNullConstraint(columnDataType: "datetime", columnName: "CREATED_AT", tableName: "USER")
	}
}
