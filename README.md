grailsnV
==========

grailsnV is a vulnerable jobs listing website.

More information about grailsnV and its vulnerabilities can be found [here](https://github.com/nVisium/grailsnV/wiki)

Setup
-----

Before setting up, you will need to have the JDK installed. Simply having the JRE is not enough. OpenJDK works well, but there
are other options as well.

To set up Groovy, we recommend using the GVM, which allows for easy installation.

    curl -s get.gvmtool.net | bash
    source "$HOME/.gvm/bin/gvm-init.sh"
    gvm install groovy
    
Afterwards, you can easily install Grails.

    gvm install grails

To set up the database, run the initial setup script provided in the directory.

    chmod +x initial-setup.sh
    ./initial-setup.sh

By default, grailsnV uses the build in H2 database stored on disc. However, the ```grails-app\conf\DataSource.groovy``` and ```initial-setup.sh``` have commented out settings to switch to MySQL if that's preferable.

To view any mail sent from the application, navigate to ```http://localhost:8080/grailsnV/greenmail```. grailsnV uses the in-memory GreenMail mailserver.

Finally, to actually run the app, simply run

    grails run-app
    
The app should then be accessible at ```http://localhost:8080/grailsnV/```

If your ```grails``` prompt shows the following message

    Class JavaLaunchHelper is implemented in both /Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home/bin/java and /Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home/jre/lib/libinstrument.dylib. One of the two will be used. Which one is undefined

You can safely ignore it. The above is a JVM error unrelated to grailsnV

Updating the Database
---------------------

Database updates use migrations. To update the database, change the domain files and then tell grails to update the migrations.

When the app starts, it will automatically bring the schema up to date.

    grails dbm-update
    grails dbm-gorm-diff YYYY-MM-DD-added-blah-blah.groovy --add
    
(from http://grails.github.io/grails-howtos/en/manageDatabases.html)