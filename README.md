grails.nV
==========

grails.nV is a vulnerable jobs listing website.

More information about grails.nV and its vulnerabilities can be found [here](https://github.com/nVisium/grails.nV/wiki)

Setup
-----

To set up Groovy, we recommend using the GVM, which allows for easy installation.

    curl -s get.gvmtool.net | bash
    source "$HOME/.gvm/bin/gvm-init.sh"
    gvm install groovy
    
Afterwards, you can easily install Grails.

    gvm install grails

To set up the database, run the initial setup script provided in the directory.

    chmod +x initial-setup.sh
    ./initial-setup.sh

In order for the app to send mail (for account verification, password resets, etc) you will need to configure the mailserver settings in the ```grails-app\Config.groovy``` file. By default, we have used settings for ```mailcatcher```, which captures all emails sent to it and displays them in a web interface.

    gem install mailcatcher
    mailcatcher

Then open ```http://localhost:1080``` and you should be able to view all emails sent to the daemon.

Finally, to actually run the app, simply run

    grails
    
And enter ```run-app``` into the prompt when it appears. The app should then be accessible at ```http://localhost:8080/grailsnv/```

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
