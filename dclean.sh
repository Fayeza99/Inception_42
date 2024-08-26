docker stop $(docker ps -aq)
docker container prune -f
docker rmi $(docker image ls -aq)
docker volume rm $(docker volume ls -aq)
docker image prune -f
docker volume prune -f
docker system prune -f