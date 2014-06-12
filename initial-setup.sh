#!/bin/bash

echo "create database \`grailsnv-dev\`" | mysql -u root
grails dbm-update
mysql -u root grailsnv-dev < data-initial.sql
