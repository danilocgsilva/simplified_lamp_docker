#!/bin/bash

clean_env_output() {
    cat .env.example | sed /^$/d | sed /^#/d
}

clean_env_output
