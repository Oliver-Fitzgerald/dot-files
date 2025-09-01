IMAGES=$(docker ps -a | awk '{print $1}')
docker kill $IMAGES
docker rm $IMAGES
docker ps -a
