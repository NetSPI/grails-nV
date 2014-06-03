databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401820126051-1") {
		modifyDataType(columnName: "latest_attempt", newDataType: "bigint", tableName: "user")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401820126051-2") {
		addNotNullConstraint(columnDataType: "bigint", columnName: "latest_attempt", tableName: "user")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401820126051-3") {
		modifyDataType(columnName: "original_attempt", newDataType: "bigint", tableName: "user")
	}

	changeSet(author: "cyrusmalekpour (generated)", id: "1401820126051-4") {
		addNotNullConstraint(columnDataType: "bigint", columnName: "original_attempt", tableName: "user")
	}
}
