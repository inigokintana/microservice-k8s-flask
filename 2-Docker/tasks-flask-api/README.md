# An easy Flask API to handle custom tasks documented with Flasgger

This is task CRUD application built using Flask and deployed on Docker based on previous work of Sejal Maniyar (MIT license):
- API is documented using Flasgger and YAML
- All API methods but root one are protected with API_KEY
- API_KEY is passed as environment variable 
- Check in appV1.py how API naming Semantic Versioning Best Practice could be done.  Basically, semantic versioning scheme (e.g., v1.2.3), in URL (Major, Minor, Patch) which follows the format of MAJOR.MINOR.PATCH. This allows more flexibility in defining changes. Not implemented through Dokerfile <->  in docker image, you can take if from here. Depending on your use case you can choose to break down Semantic Versioning into something else, see:
    - [Semantic versioning](https://apisyouwonthate.com/blog/versioning-apis-semantically/).
    - [Best practices](https://blog.treblle.com/my-version-api-versioning-better-than-most-versiong-being-done/?ref=apisyouwonthate.com)
    - [API versioning in Python](https://blog.treblle.com/api-versioning-in-python-2/)


## 1 - To test it locally
Notice lines 36-37 in app.py - "API Key read it from environment - to pass it with docker -e"
- env_api_key = os.getenv('API_KEY')

Run it with docker on port 5000 or any other port passing the environment variable with -e option
- sudo docker run -e API_KEY='whatever-api-key' -it --rm -p 5000:8080 --name flasgger ikzdocker/task-api-flasgger

Test whatever API endooint with the browser or curl:
- curl "http://localhost:5000/"
- curl -X GET "http://localhost:5000/tasks" -H "accept: application/json" -H "X-Access-Token: whatever-api-key" - MongoDB is missing it will return error - We are going to use MongoDB image on K8S


## 2 -Load into dockerHub
Once you have fine tune your docker image

### Login in to your dockerhub account https://hub.docker.com/
sudo docker login
### Build image locally setting a tag
sudo docker build -t <your-repo>/task-api-flasgger .
sudo docker image list
### Push your local image to dockerhub https://hub.docker.com/
sudo docker push  <your-repo>/task-api-flasgger:latest