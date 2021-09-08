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
    REPLACEMENT_TERM=\${$VARIABLE_NAME}
    for i in $(grep -r $REPLACEMENT_TERM); do
        FILE_FOUND=$(echo $i | cut -f1 -d:)
        sed -i "s@$REPLACEMENT_TERM@$VARIABLE_VALUE@g" $FILE_FOUND
    done
done
IFS=$ORIGINAL_IFS
