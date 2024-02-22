#!/usr/bin/env bash
set -x
set -eo pipefail

# Allow to skip Docker if a dockerized Postgres database is already running
if [[ -z "${SKIP_DOCKER}" ]]
then
  docker-compose down
  docker-compose up -d
fi

sleep 2

DATABASE_URL=postgres://postgres:password@localhost:5432/newsletter

# Create the database
DATABASE_URL=$DATABASE_URL sqlx database create

# Run the migrations
DATABASE_URL=$DATABASE_URL sqlx migrate run

