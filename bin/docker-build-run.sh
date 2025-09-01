docker rmi -f $1 && \
docker build -t $1 . $2 && \
docker run -d $1 && \
docker ps -a | grep $1 | awk '{print $1}'
LAST_DOCKER_IMAGE=$(docker ps -a | grep $1 | awk '{print $1}')
