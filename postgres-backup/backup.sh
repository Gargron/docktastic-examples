#! /bin/sh

# Announce backup details
echo "Going to back up Postgres databases at:"
echo "Host: $MASTER_PORT_5432_TCP_ADDR"
echo "Port: $MASTER_PORT_5432_TCP_PORT"
echo "User: $MASTER_ENV_POSTGRES_USER"

# Prevent password prompts
export PGPASSWORD="$MASTER_ENV_POSTGRES_PASSWORD"

# Define output filename
BACKUP_FILENAME=db_`date +\%Y-\%m-\%d_\%H\%M`_full.sql.gz

# Dump all databases
pg_dumpall -U "$MASTER_ENV_POSTGRES_USER" -h "$MASTER_PORT_5432_TCP_ADDR" -p "$MASTER_PORT_5432_TCP_PORT" -w | gzip > "/backup/$BACKUP_FILENAME"

echo "----------"
echo "Completed!"
echo "Saved under: /backup/$BACKUP_FILENAME"
