#! /bin/sh

redis-server &

# To use the container as a slave node for another redis instance,
# link it to the master container using the alias "slaveof"
if env | grep -q ^SLAVEOF_
then
  sleep 3
  echo "Master link detected, enslaving self...";
  redis-cli SLAVEOF "$SLAVEOF_PORT_6379_TCP_ADDR" "$SLAVEOF_PORT_6379_TCP_PORT"
fi

wait
