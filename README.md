grails.nV
==========

grails.nV is a vulnerable jobs listing website.

More information about grails.nV and its vulnerabilities can be found [here](https://github.com/nVisium/grails.nV/wiki)

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

By default, grails.nV uses the build in H2 database stored on disc. However, the ```grails-app\conf\DataSource.groovy``` and ```initial-setup.sh``` have commented out settings to switch to MySQL if that's preferable.

In order for the app to send mail (for account verification, password resets, etc) you will need to configure the mailserver settings in the ```grails-app\conf\Config.groovy``` file. By default, we have used settings for ```mailcatcher```, which captures all emails sent to it and displays them in a web interface. You'll need to install Ruby if you choose to use it.

    gem install mailcatcher
    mailcatcher

Then open ```http://localhost:1080``` and you should be able to view all emails sent to the daemon.

Finally, to actually run the app, simply run

    grails run-app
    
The app should then be accessible at ```http://localhost:8080/grails.nV/```

If your ```grails``` prompt shows the following message

    Class JavaLaunchHelper is implemented in both /Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home/bin/java and /Library/Java/JavaVirtualMachines/jdk1.7.0_60.jdk/Contents/Home/jre/lib/libinstrument.dylib. One of the two will be used. Which one is undefined

You can safely ignore it. The above is a JVM error unrelated to grails.nV

Updating the Database
---------------------

Database updates use migrations. To update the database, change the domain files and then tell grails to update the migrations.

When the app starts, it will automatically bring the schema up to date.

    grails dbm-update
    grails dbm-gorm-diff YYYY-MM-DD-added-blah-blah.groovy --add
    
(from http://grails.github.io/grails-howtos/en/manageDatabases.html)
