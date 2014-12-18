# Example Sinatra App with Redis

This is a demo Sinatra app that displays all values in a given Redis database. To start it,
you would first create a Redis container, for example like this:

    docker run -p 6379 --name=redis-master tastic/redis

Then you would link this app with it using the alias "redis":

    docker run -p 3000 --link redis-master:redis tastic/sinatra-redis-example

You could also manually set the environment variables `REDIS_PORT_6379_TCP_ADDR` and
`REDIS_PORT_6379_TCP_PORT` to point to the Redis instance.
