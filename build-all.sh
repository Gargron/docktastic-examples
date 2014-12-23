echo "Building all example images..."
docker build -t tastic/postgres postgres
docker build -t tastic/postgres-backup postgres-backup
docker build -t tastic/redis redis
docker build -t tastic/sinatra sinatra
docker build -t tastic/sinatra-redis sinatra-redis
echo "Done!"
