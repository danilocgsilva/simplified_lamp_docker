#!/bin/bash

set -e

FILE_TARGET=.env

replace() {
    OLD_PORT=$(sed -n $1p $FILE_TARGET | cut -f2 -d=)
    VARIABLE=$(sed -n $1p $FILE_TARGET | cut -f1 -d=)
    NEW_PORT=$(expr $OLD_PORT + 1)

    sed -i $1s/$OLD_PORT/$NEW_PORT/g $FILE_TARGET
    echo The variable $VARIABLE in $FILE_TARGET changed. From $OLD_PORT to $NEW_PORT
}

lines_to_replace=( $(cat .env.example | cat -n | grep -i port | awk '{print $1}') )

for i in "${lines_to_replace[@]}"
do
   replace $i
done
