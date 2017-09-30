#!/usr/bin/env bash
# sudo -u postgres

if [ -z "$REST_PASS" ]; then
    >&2 echo "REST_PASS is undefined"
    exit 2
fi

POSTGRES_DB_USER="${POSTGRES_DB_USER:-streamerus}";
POSTGRES_DB_NAME="${POSTGRES_DB_NAME:-streamerdb}";

#createuser --superuser "$POSTGRES_DB_USER"
#psql -c "CREATE USER $POSTGRES_DB_USER WITH LOGIN PASSWORD '$REST_PASS';"
#createdb "$POSTGRES_DB_NAME" --owner "$POSTGRES_DB_USER"

e="export RDBMS_URI=postgres://$POSTGRES_DB_USER:$REST_PASS@localhost/$POSTGRES_DB_NAME"
echo e >> "$HOME/.bash_profile"
printf '%s\n%s\n\n' 'Add this to your env var location:' "$e"