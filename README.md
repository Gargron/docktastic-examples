# Tutorial: Running a Sinatra app with a Redis cluster

First build all example images by running `./build-all.sh`

## Using Docker only

~~~bash
docker run -p 6379:6379 --name master -d tastic/redis

docker run -p 6379 --name slave0 --link master:slaveof -d tastic/redis
docker run -p 6379 --name slave1 --link master:slaveof -d tastic/redis

docker run -p 3000 --link master:redis_write --link slave0:redis_read -d tastic/sinatra-redis
docker run -p 3000 --link master:redis_write --link slave1:redis_read -d tastic/sinatra-redis
~~~

Explanation: You create a named instance of the master Redis image with the exposed port 6379. You then create two
instances of the Redis image, named, linked to the master image. At last, you create two frontend instances, linked
to both the master (for writes) and the corresponding slave (for reads).

## Using Docktastic

*You need to have at least two nodes in the cluster since the ports between master and slaves are shared; so one node
would host the master instance, and other nodes would contain the slaves and/or front-end apps.*

First, create a cluster:

~~~bash
bin/tastic cluster setup 172.17.42.1 home0
~~~

Then, define the services:

~~~bash
bin/tastic create redis-master tastic/redis -p 8000:6379

bin/tastic create redis-slave tastic/redis -p 8010:6379 -e \
  SLAVEOF_PORT_6379_TCP_ADDR=redis-master \
  SLAVEOF_PORT_6379_TCP_PORT=8000

bin/tastic create sinatra-app tastic/sinatra-redis -p 3000 -e \
  REDIS_WRITE_PORT_6379_TCP_ADDR=redis-master \
  REDIS_WRITE_PORT_6379_TCP_PORT=8000 \
  REDIS_READ_PORT_6379_TCP_ADDR=redis-slave \
  REDIS_READ_PORT_6379_TCP_PORT=8010
~~~

As you see, we refer to the dependent services by name. The Consul DNS service running in the background will match
the names to the correct containers while load-balancing. The `-p` argument determines the mapping between the container port (6379) and the host port (in our case, different host ports for master and slave, due to us having only one node to work with).

The last step is making Docktastic run these services on the cluster:

~~~bash
bin/tastic dist -s redis-master -n home0:1 --no-pull
bin/tastic dist -s redis-slave -n home0:1 --no-pull
bin/tastic dist -s sinatra-app -n home0:3 --no-pull
~~~

The `--no-pull` flag tells Docktastic not to look up the images in the online repository, rather relying solely on the
local cache, which we built all the examples into.

We should now be able to access a (round-robin load balanced) Sinatra app under <http://sinatra-app.172.17.42.1.xip.io>.
