#!/bin/bash

# Get the pure data from .env.example file
clean_env_output() {
    cat .env.example | sed /^$/d | sed /^#/d
}

# List all occurrences of replacements requirements
list_destinies() {
    grep -iRE '\${' *
}

ORIGINAL_IFS=$IFS
IFS=$'\n'
for i in $(clean_env_output); do
    VARIABLE_NAME=$(echo $i | cut -f1 -d'=')
    VARIABLE_VALUE=$(echo $i | cut -f2 -d'=')
    TERM_FOR_REPLACEMENT="\${$VARIABLE_NAME}"
    echo ----
    echo "The variable is $VARIABLE_NAME"
    echo "The variable value is $VARIABLE_VALUE"
    echo "The expected term in files is $TERM_FOR_REPLACEMENT"
    TERM_FOR_REPLACEMENT_SCAPED=$(echo $TERM_FOR_REPLACEMENT | sed s/\{/{/g)
    echo "The scaped term is $TERM_FOR_REPLACEMENT_SCAPED"
    
    #for j in $(grep -R "$TERM_FOR_REPLACEMENT" *); do
    #    FILE_TO_REPLACE=$(echo $j | cut -f1 -d:)
    #    echo File to replace: $FILE_TO_REPLACE
    #    sed -i "s/${MARIADB_ENTRYPOINT_INITDB}/$VARIABLE_VALUE/g" $FILE_TO_REPLACE 
    #done
    echo ----
done
IFS=$ORIGINAL_IFS
