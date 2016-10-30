CPP Carpool DB
----
Postgres database for cpp carpool application

Requirements:
1. docker
2. make

## Building
```
make build
```
Running make build will build the docker image and create the database tables

## Local Dev
```
make dev
```
The db listens on port 5432.
The default user is "postgres" with no password
