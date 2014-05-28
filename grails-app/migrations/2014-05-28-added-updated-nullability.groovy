databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401306152228-1") {
		modifyDataType(columnName: "UPDATED_AT", newDataType: "datetime", tableName: "USER")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401306152228-2") {
		dropNotNullConstraint(columnDataType: "datetime", columnName: "UPDATED_AT", tableName: "USER")
	}
}
