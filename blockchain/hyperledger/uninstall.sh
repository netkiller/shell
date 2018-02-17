docker rm -f $(docker ps -q -a)
docker rmi -f $(docker images -q)