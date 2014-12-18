# Example Postgres app

Usage:

    docker run --name=psql-master -e POSTGRES_USER=foo -e POSTGRES_PASSWORD=bar -d tastic/postgres

Will create a container with PSQL user foo with the password bar, named psql-master so you can link it to
other containers.
