#!/usr/bin/env bash
# sudo -u postgres

if [ -z "$REST_PASS" ]; then
	>&2 echo "REST_PASS is undefined"
	exit 2
fi

POSTGRES_DB_USER="${POSTGRES_DB_USER:-'streamerus'}";
POSTGRES_DB_NAME="${POSTGRES_DB_NAME:-'streamerdb'}";

#createuser --superuser "$POSTGRES_DB_USER"
psql -c "create role $POSTGRES_DB_USER with login password '$REST_PASS';"
createdb "$POSTGRES_DB_NAME" --owner "$POSTGRES_DB_USER"

echo "export RDBMS_URI=postgres://$POSTGRES_DB_USER:$REST_PASS@localhost/$POSTGRES_DB_NAME" >> "$HOME/.bash_profile"
