# pg_initialaser [![Build Status](https://travis-ci.org/HackGT/pg_initialaser.svg?branch=master)](https://travis-ci.org/HackGT/pg_initialaser)

Simple script packaged into a Docker container that creates a Postgres user
and database on a given host specified in environment variables.
Realtalk: this project is a 2 line script that runs `CREATE USER` and
`CREATE DATABASE`.

## Environment variables

| Name     | Description                                                            |
| ----     | -----------                                                            |
| PGHOST   | (connection option) Postgres host                                      |
| PGUSER   | (connection option) Postgres admin user                                |
| USERNAME | Username for the user to be created                                    |
| DBNAME   | Name for the database to be created (owner is set to the created user) |

## Background

Initial/intended purpose is for usage as an [Init Container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
in [HackGT/biodomes](https://github.com/HackGT/biodomes) for applications that use Postgres as a datastore.
This image allows biodomes to create a new user and database for each deployment
of each application that uses Postgres (ex. each PR will have a separate db
and all isolated from each other - and production).

See [HackGT/biodomes#16](https://github.com/HackGT/biodomes/pull/16) for more context.
