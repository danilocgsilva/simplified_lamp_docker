# Simplified lamp docker receipt

## First first

Thanks to give a break, thus you are reading this file. Hope you are here first instead be here just because you stumbled in any difficulty on raising this project.

## Second (if still not used to Docker): prerequisites

* Have Docker installed in your environment.
* Have locally the `docker-compose` command line utility to rushes and facilitates the tasks.

## Finally the must awaited step-by-step

1. If you aren't already, go to the project's root folder.
2. Copy the `.env.example` file to another one called `.env` in the same folder.
3. (Don't be lazy) and give a quick, really quick look to the `.env` file content. May you need to change something, or even get the basic information to use the containers rised.
4. Executes: `docker-compose up -d --build`. Checks in the console output if all services have sucesfully raised. If not, better no know that the most common reasons why the docker receipt fails is due to *port conflict*. If so, it is easy to fix: just change the conflicting ports to any value in the `.env` file and run `docker-compose up -d --build` again.

Hope not hurted reading the README.

...

It should be enough if you have some experience in Docker and in a lamp environment. This is enough to make the project up and running.
