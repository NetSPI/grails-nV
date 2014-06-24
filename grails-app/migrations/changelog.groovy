databaseChangeLog = {

	changeSet(author: "cyrusmalekpour (generated)", id: "1401301791279-1") {
		createTable(tableName: "USER") {
			column(autoIncrement: "true", name: "ID", type: "BIGINT") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "CONSTRAINT_2")
			}

			column(name: "VERSION", type: "BIGINT") {
				constraints(nullable: "false")
			}

			column(name: "AUTH_TOKEN", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "CREATED_AT", type: "TIMESTAMP") {
				constraints(nullable: "false")
			}

			column(name: "EMAIL", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "FIRSTNAME", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "LASTNAME", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "PASSWORD", type: "VARCHAR(255)") {
				constraints(nullable: "false")
			}

			column(name: "UPDATED_AT", type: "TIMESTAMP") {
				constraints(nullable: "false")
			}

			column(name: "VERIFIED", type: "BOOLEAN")
		}
	}

	include file: '2014-05-28-initial-database.groovy'

	include file: '2014-05-28-added-updated-nullability.groovy'

	include file: '2014-05-28-added-default-user-values.groovy'

	include file: '2014-05-28-added-updated-constraints.groovy'

	include file: '2014-05-28-added-job-listing.groovy'

	include file: '2014-05-29-added-nullability-on-auth_token.groovy'

	include file: '2014-05-29-updated-token-fields.groovy'

	include file: '2014-05-29-updated-token-fields-again.groovy'

	include file: '2014-05-29-added-job-listing-company.groovy'

	include file: '2014-05-29-added-nullable-created.groovy'

	include file: '2014-05-30-added-user-description.groovy'

	include file: '2014-05-30-user-resumes.groovy'

	include file: '2014-06-02-added-messages.groovy'

	include file: '2014-06-02-added-fullname-to-user.groovy'

	include file: '2014-06-02-more-message-tweaks.groovy'

	include file: '2014-06-02-analytics.groovy'

	include file: '2014-06-02-added-field-constraints.groovy'

	include file: '2014-06-02-added-log-constraints.groovy'

	include file: '2014-06-02-added-log-nullables.groovy'

	include file: '2014-06-02-added-user-access-level.groovy'

	include file: '2014-06-02-added-user-lockout-fields.groovy'

	include file: '2014-06-02-added-user-reset-token.groovy'

	include file: '2014-06-02-changed-field-types.groovy'

	include file: '2014-06-02-changed-field-types-again.groovy'

	include file: '2014-06-02-changed-field-types-again-again.groovy'

	include file: '2014-06-04-added-user-ssn.groovy'

	include file: '2014-06-24-adding-employees.groovy'
}
