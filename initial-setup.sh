#!/bin/bash

echo "create database \`grailsgoat-dev\`" | mysql -u root
grails dbm-update
mysql -u root grailsgoat-dev < data-initial.sql
