createuser -w --no-replication --no-createdb --no-createrole --no-superuser "$USERNAME"
createdb -w --owner="$USERNAME" "$DATABASE"
