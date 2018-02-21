# pg_initialaser [![Build Status](https://travis-ci.org/HackGT/pg_initialaser.svg?branch=master)](https://travis-ci.org/HackGT/pg_initialaser)

Simple script packaged into a Docker container that creates a Postgres user
and database on a given host specified in environment variables.

## Environment variables

| Name     | Description                                                            |
| ----     | -----------                                                            |
| PGHOST   | (connection option) Postgres host                                      |
| PGUSER   | (connection option) Postgres admin user                                |
| USERNAME | Username for the user to be created                                    |
| DBNAME   | Name for the database to be created (owner is set to the created user) |
