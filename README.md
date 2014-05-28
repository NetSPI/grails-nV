grailsgoat
==========

Vulnerable Grails application

Setup
-----

(Something about installing groovy, grails, how it requires java 1.7, etc)

To set up the database, run the initial setup script provided in the directory.

    chmod +x initial_setup.sh
    ./initial_setup.sh

Updating the Database
---------------------

Database updates use migrations. To update the database, change the domain files and then tell grails to update the migrations.

When the app starts, it will automatically bring the schema up to date.

    grails dbm-update
    grails dbm-gorm-diff YYYY-MM-DD-added-blah-blah.groovy --add
    
(from http://grails.github.io/grails-howtos/en/manageDatabases.html)
