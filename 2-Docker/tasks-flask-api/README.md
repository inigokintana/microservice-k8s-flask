# 1 - Should I use a distroless or not docker image for Flask application server?


|Feature	|Non-Distroless Images	|Distroless Images|
|-----------|-----------------------|-----------------|
|Size	|Larger	|Smaller|
|Security	|Higher attack surface	|Reduced attack surface
|Performance	|Potentially less efficient	|Potentially more efficient
|Debugging	|Easy with familiar tools	|Requires alternative methods
|Flexibility	|Easy to install software	|More complex to add software

When to use which:

**Non-Distroless**:
During development, when ease of use and debugging are priorities **OUR USE CASE**.
For applications that require a wide range of utilities or have complex dependencies.

**Distroless**:
For production environments where security and efficiency are paramount.
For applications with well-defined dependencies and minimal need for runtime modifications. [See link](https://www.linkedin.com/pulse/distroless-images-python-flask-perfect-combination-fast-chatterjee-qgbjc/)

# 2- My project is an easy Flask REST API to manage custom tasks documented with Flasgger

This is task CRUD application built using Flask and deployed on Docker based on previous work of [Sejal Maniyar](https://github.com/sejal1011/microservices-k8s/tree/main/microservices-k8s-main) (MIT license). Some improvements to Sejal's work are:
- REST API is documented using Flasgger and YAML
- All API methods but home one are protected with API_KEY
- API_KEY is passed as environment variable 
- Check in appV1-semantic-versioning-example.py to see how API naming Semantic Versioning Best Practice could be done.  Basically, semantic versioning scheme (e.g., v1.2.3), in URL (Major, Minor, Patch) which follows the format of MAJOR.MINOR.PATCH. This allows more flexibility in defining changes. Not implemented in Dokerfile <->  in docker image, you can take if from here. Depending on your use case you can choose to break down Semantic Versioning into something else, see:
    - [Semantic versioning](https://apisyouwonthate.com/blog/versioning-apis-semantically/).
    - [Best practices](https://blog.treblle.com/my-version-api-versioning-better-than-most-versiong-being-done/?ref=apisyouwonthate.com)
    - [API versioning in Python](https://blog.treblle.com/api-versioning-in-python-2/)


## 2.1 - To test it locally
Notice lines 36-37 in app.py - "API Key read it from environment - to pass it with docker -e"
- env_api_key = os.getenv('API_KEY')

Run it with docker on port 5000 or any other port passing the environment variable with -e option
- sudo docker run -e API_KEY='whatever-api-key' -it --rm -p 5000:8080 --name flasgger ikzdocker/task-api-flasgger

Test whatever API endpoint with the browser or curl:
- curl "http://localhost:5000/"
- curl -X GET "http://localhost:5000/tasks" -H "accept: application/json" -H "X-Access-Token: whatever-api-key" - MongoDB is missing it will return error - We are going to use MongoDB image directly inside K8S


## 2.2 -Load into dockerHub
Once you have fine tune your docker image application

### 2.2.1 - Login in to your dockerhub account https://hub.docker.com/
sudo docker login
### 2.2.2 - Build image locally setting a tag
sudo docker build -t <your-repo>/task-api-flasgger .
sudo docker image list
### 2.2.3 - Push your local image to dockerhub https://hub.docker.com/
sudo docker push  <your-repo>/task-api-flasgger:latest

