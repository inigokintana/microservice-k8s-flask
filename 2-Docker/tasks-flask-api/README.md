# An eeasy Flask API to handle tasks documented with Flasgger

## Login in to your dockerhub account https://hub.docker.com/
sudo docker login
## Build image locally setting a tag
sudo docker build -t ikzdocker/task-api-flasgger .
sudo docker image list
## Push your local image to dockerhub https://hub.docker.com/
sudo docker push  ikzdocker/task-api-flasgger:latest