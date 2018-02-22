# pg_initialaser [![Build Status](https://travis-ci.org/HackGT/pg_initialaser.svg?branch=master)](https://travis-ci.org/HackGT/pg_initialaser)

A simple script packaged into a Docker container that idempotent-ly creates
a Postgres user and database on a given host specified in environment variables.
Realtalk:tm:: this project is a 2 line script that runs `CREATE USER` and
`CREATE DATABASE`.

**Note:** The user that is created has restricted permissions (only has access
to the created database). It also does not have a password.

## Environment variables

| Name         | Description                                                                                  |
| ----         | -----------                                                                                  |
| POSTGRES_URL | (connection option) Connection string for the Postgres server. This should be an admin user. |
| USERNAME     | Username for the user to be created                                                          |
| DBNAME       | Name for the database to be created (owner is set to the created user)                       |

## Exit Codes

`pg_initializer` will only exit with an error code (exit code != 0) when `psql`
has issues connecting to the database. `psql` does not error when SQL errors are
encountered, helping make the containerized utility idempotent.

## Usage as an [Init Container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)

MongoDB allows applications to upsert databases(!) by simply connecting and
writing. If no existing database exists at that path then a new database is
created and the data is written there.

Postgres does not work this way.

Instead, a superuser (or other user with proper permissions) needs to explicitly
create a database. `pg_initializer` does this after first creating a user with
restricted permissions and then creates a database with that user as the owner.
Because duplicate user/database errors do not produce error codes on exit, this
utility is suitable for usage as an init container - exit 0'ing when both the
user and database exist.

Additionally, because connection failures will result in an error code, this
init container will prevent apps that depend on Postgres from starting when
the database server is down.

## Background

This was created to be used as an [Init Container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)
in [HackGT/biodomes](https://github.com/HackGT/biodomes) for applications that use Postgres as a datastore.
This image allows biodomes to create a new user and database for each deployment
of each application that uses Postgres (each PR will have a separate db and all
isolated from each other - and production).

See [HackGT/biodomes#16](https://github.com/HackGT/biodomes/pull/16) for more context.
