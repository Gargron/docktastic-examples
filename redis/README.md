# Example Redis app

This is a Redis container that can optionally run as a slave. Typical setup, first
the master:

    docker run -p 6379 --name=master tastic/redis

Then the slave:

    docker run -p 6379 --link master:slaveof tastic/redis

You can set the environment variables manually: `SLAVEOF_NAME` is expected to be set for the slave
initialization to set in; `SLAVEOF_PORT_6379_TCP_ADDR` and `SLAVEOF_PORT_6379_TCP_PORT` should point to the
master Redis instance.
