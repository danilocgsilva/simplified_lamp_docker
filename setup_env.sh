#!/bin/bash

set -e

INTEREST_FILE=".env"

CURRENT_ENVIRONMENT_NAME=$(cat $INTEREST_FILE | grep COMPOSE_PROJECT_NAME | cut -f2 -d=)
CURRENT_DATABASE_NAME=$(cat $INTEREST_FILE | grep MARIADB_DATABASE | cut -f2 -d=)
CURRENT_DATABASE_USER=$(cat $INTEREST_FILE | grep MARIADB_USER | cut -f2 -d=)
CURRENT_DATABASE_PASSWORD=$(cat $INTEREST_FILE | grep MARIADB_PASSWORD | cut -f2 -d=)
CURRENT_DATABASE_PORT=$(cat $INTEREST_FILE | grep MARIADB_PORT | cut -f2 -d=)
CURRENT_WEBSERVER_PORT=$(cat $INTEREST_FILE | grep NGINX_HOST_HTTP_PORT | cut -f2 -d=)
CURRENT_SECURE_WEBSERVER_PORT=$(cat $INTEREST_FILE | grep NGINX_HOST_HTTPS_PORT | cut -f2 -d=)
    
echo "Currently, the environment name is: $CURRENT_ENVIRONMENT_NAME"
read -p "Give to the environment a new name: " NEW_ENVIRONMENT_NAME
sed -i "/COMPOSE_PROJECT_NAME/s/$CURRENT_ENVIRONMENT_NAME/$NEW_ENVIRONMENT_NAME/g" $INTEREST_FILE
echo "The new project name now is $NEW_ENVIRONMENT_NAME"

read -p "The database user is: $CURRENT_DATABASE_USER. Would you like to change to something else? (keep blank to keep same value) " NEW_DESIRED_DB_USER
if ! [ -z $NEW_DESIRED_DB_USER ]; then
    sed -i "//"
fi

echo "The database password is: $CURRENT_DATABASE_PASSWORD"
echo "The database name is: $CURRENT_DATABASE_NAME"
echo " --- ports --- "
echo "The current webservice port is: $CURRENT_DATABASE_PORT"
echo "The current webservice secure port is: $CURRENT_SECURE_WEBSERVER_PORT"
echo "The current database port is: $CURRENT_DATABASE_PORT"
echo "Now, if you are raising another environment, will be good to run the script port_rotate.sh, so new environments won't have conflited."
