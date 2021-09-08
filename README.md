# Simplified lamp docker receipt

## Quick navigation:

* [port_rotate.sh](#port_rotate.sh)
* [setup_env.sh](#setup_env.sh)
* [envhere.sh](#envhere.sh)

## Prerequisites

* Have Docker installed in your environment.
* Have locally the `docker-compose` command line utility to rushes and facilitates the tasks.

## Step-by-step

1. If you aren't already, go to the project's root folder.
2. Copy the `.env.example` file to another one called `.env` in the same folder.
3. (Don't be lazy) and give a quick, really quick look to the `.env` file content. May you need to change something, or even get the basic information to use the containers rised.
4. Executes: `docker-compose up -d --build`. Checks in the console output if all services have sucesfully raised. If not, better no know that the most common reasons why the docker receipt fails is due to *port conflict*. If so, it is easy to fix: just change the conflicting ports to any value in the `.env` file and run `docker-compose up -d --build` again.

It should be enough if you have some experience in Docker and in a lamp environment. This is enough to make the project up and running.

## Writing a site based on current webservice from Docker

Just create a folder called public in the same level as the project's folder (not in the root, right aside from project's folder) and starts to write the site. Is there that the `index.html` or `index.php` file will be read.

## `port_rotate_env.sh`

Checks the `port_rotate.sh` script on project's root folder. Run this script to rise by 1 all ports setted in the `.env` file.

## `setup_env.sh`

Run this script to conveniently change the name from the environment, database user, database password, database starting table and ports for http, https and mysql.

## `envhere.sh`

Put this file in `/usr/local/bin`, rename it to `envhere` (without file extension) and make it executable. Then execute anywhere in your system to clone a new project in the current folder.

## `remove_env.sh`

Replaces all occurrences on `docker-compose.yml` that uses some variable from `.env` file, getting the values from `.env.example` file.
