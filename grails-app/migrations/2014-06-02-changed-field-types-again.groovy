databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401820437561-1") {
		addNotNullConstraint(columnDataType: "bigint", columnName: "latest_attempt", tableName: "user")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401820437561-2") {
		modifyDataType(columnName: "original_attempt", newDataType: "bigint", tableName: "user")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401820437561-3") {
		addNotNullConstraint(columnDataType: "bigint", columnName: "original_attempt", tableName: "user")
	}
}
