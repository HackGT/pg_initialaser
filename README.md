# pg_initialaser [![Build Status](https://travis-ci.org/HackGT/pg_initialaser.svg?branch=master)](https://travis-ci.org/HackGT/pg_initialaser)

A simple script packaged into a Docker container that creates idempotent-ly
a Postgres user and database on a given host specified in environment variables.
Realtalk: this project is a 2 line script that runs `CREATE USER` and
`CREATE DATABASE`.

**Note:** The user that is created has severely restricted permissions (only has
access to the created database). It also does not have a password.

## Environment variables

| Name         | Description                                                                                  |
| ----         | -----------                                                                                  |
| POSTGRES_URL | (connection option) Connection string for the Postgres server. This should be an admin user. |
| USERNAME     | Username for the user to be created                                                          |
| DBNAME       | Name for the database to be created (owner is set to the created user)                       |

## Exit Codes

`pg_initializer` will only exit with an error code (exit code != 0) when `psql`
has issues connecting to the database. `psql` does not error when SQL errors are
encountered, making the containized utility idempotent.

## Background

Initial/intended purpose is for usage as an [Init Container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
in [HackGT/biodomes](https://github.com/HackGT/biodomes) for applications that use Postgres as a datastore.
This image allows biodomes to create a new user and database for each deployment
of each application that uses Postgres (ex. each PR will have a separate db
and all isolated from each other - and production).

See [HackGT/biodomes#16](https://github.com/HackGT/biodomes/pull/16) for more context.
