# Postgres backup image

Usage:

    mkdir ~/postgres-backup
    docker run --link psql-master:master -v ~/postgres-backup:/backup tastic/postgres-backup

This will link a running container named postgres-master to this one, and mount the host directory `postgres-backup` of the current host user in the container. The backup script will dump the master Postgres database there and terminate.
