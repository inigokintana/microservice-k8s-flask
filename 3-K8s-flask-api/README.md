# Kubernetes Microservice Flask Application

This is a microservice task application built using Flask and deployed on Kubernetes based on previous work of 
Sejal Maniyar (MIT license):
- [Medium article](https://medium.com/@sejalmaniyar9/kubernetes-microservice-flask-application-aaf28f10ab38)
- [Github](https://github.com/sejal1011/microservices-k8s.git)

It is designed to demonstrate how to build and deploy microservices on a Kubernetes cluster adding some extra features:
- API is documented using Flasgger and YAML
- All API methods but one are protected with API_KEY
- API_KEY is saved in K8S secret and passed as environment variable to K8S container
- some ideas TO-DO: secret in AWS secret, api request limit with NGINX Ingress Controller, Traefik, Ambassador,  Kong or Flask-limiter, api versioning, add Gunicorn ...

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Installation

To install and run the application on your Kubernetes cluster, follow these steps:

1. Clone this repository to your local machine.
2. Navigate to the project root directory.
3. Create a Kubernetes deployment and service by running the following command:

`kubectl apply -f kubernetes.yaml`

4. Verify that the deployment and service have been created successfully by running the following command:

`kubectl get deployments,services`

5. If everything is working properly, you should see the name of your deployment and service listed in the output.

## Usage

To use the microservice, you can send HTTP requests to the service's endpoint. Here's an example request:

`curl http://<service-ip>:<service-port>/tasks`

This should return a JSON response with a greeting message.

Some other requests:

    curl -X POST "http://[K8S-server]:30008/task" -H "accept: application/json" -H "x-access-token: XXXXXX" -H "Content-Type: application/json" -d "{ \"id\": 0, \"task\": \"string\"}"

    curl -X POST "http://[K8S-server]:30008/task" -H "accept: application/json" -H "x-access-token: XXXXXX" -H "Content-Type: application/json" -d @./sample1.json

## Contributing

If you'd like to contribute to this project, please fork the repository and create a new branch. Pull requests are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE.md](https://opensource.org/license/mit)

