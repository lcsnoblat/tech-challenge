#!/bin/bash
while ! pg_isready -q -h $PGHOST -p $PGPORT -U $PGUSER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

# Create, migrate, and seed database if it doesn't exist.
if [[ -z `psql -Atqc "\\list $PGDATABASE"` ]]; then
  echo "Database $PGDATABASE does not exist. Creating..."
  mix ecto.create
  mix ecto.migrate
  echo "chegou aqui"
  mix run priv/repo/seeds.exs
  echo "Database $PGDATABASE created."
fi

mix ecto.reset
mix run priv/repo/seeds/account_seeds.ex

exec mix phx.server