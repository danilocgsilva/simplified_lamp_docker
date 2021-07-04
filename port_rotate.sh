#!/bin/bash

set -e

FILE_TARGET=.env

if [ $(uname -s) = Darwin ]; then
    if ! which gsed >> /dev/null; then
        echo You are on a Mac, right? Sorry! You need first to install the gnu-sed utility via homebrew to make it work.
        exit
    else
        SEDEXEC=gsed
    fi
else
    SEDEXEC=sed
fi

replace() {
    OLD_PORT=$(sed -n $1p $FILE_TARGET | cut -f2 -d=)
    VARIABLE=$(sed -n $1p $FILE_TARGET | cut -f1 -d=)
    NEW_PORT=$(expr $OLD_PORT + 1)

    $SEDEXEC -i $1s/$OLD_PORT/$NEW_PORT/g $FILE_TARGET
    echo The variable $VARIABLE in $FILE_TARGET changed. From $OLD_PORT to $NEW_PORT
}

lines_to_replace=( $(cat .env.example | cat -n | grep -i port | awk '{print $1}') )

for i in "${lines_to_replace[@]}"
do
   replace $i
done
