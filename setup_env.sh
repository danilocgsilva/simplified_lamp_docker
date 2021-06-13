#!/bin/bash

set -e

INTEREST_FILE=".env"

if ! [ -f $INTEREST_FILE ]; then
    cp .env.example $INTEREST_FILE
fi

update() {

    BASE_MESSAGE=$1
    CURRENT=$2
    FILE_SEARCH_TERM=$3

    MESSAGE_TRANSLATED=$(printf "$BASE_MESSAGE" $CURRENT)

    read -p "$MESSAGE_TRANSLATED " NEW_VALUE
    if ! [ -z $NEW_VALUE ]; then
        sed -i "/$FILE_SEARCH_TERM/s/$CURRENT/$NEW_VALUE/g" $INTEREST_FILE
    fi
}

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

update \
    "The database user is: %s. Would you like to change to something else? (keep blank to keep same value) " \
    $CURRENT_DATABASE_USER \
    MARIADB_USER

update \
    "The database name is: %s. Would you like to change to something else? (keep blank to keep same value) " \
    $CURRENT_DATABASE_NAME \
    MARIADB_DATABASE

update \
    "The database password is: %s. Would you like to change to something else? (keep blank to keep same value) " \
    $CURRENT_DATABASE_PASSWORD \
    MARIADB_PASSWORD

update \
    "Port for webserver. Currently is %s. Type another, or keep blank to keep same value " \
    $CURRENT_WEBSERVER_PORT \
    NGINX_HOST_HTTP_PORT

update \
    "Port for webserver, secure port. Currently is %s. Type another, or keep blank to keep same value " \
    $CURRENT_SECURE_WEBSERVER_PORT \
    NGINX_HOST_HTTPS_PORT

update \
    "Port for database. Currently is %s. Type another, or keep blank to keep same value " \
    $CURRENT_DATABASE_PORT \
    MARIADB_PORT

read -p "Build and run? Type \"yes\" or anything else to build later. " RESPONSE
if ! [ -z $RESPONSE ] && [ $RESPONSE = yes ]; then
    docker-compose up -d --build
fi
