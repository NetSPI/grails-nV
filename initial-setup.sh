#!/bin/bash

# Commented out lines only apply if you are using MySQL
# instead of the built-in H2 database

grails compile
# echo "create database \`grailsnv-dev\`" | mysql -u root
grails dbm-update
