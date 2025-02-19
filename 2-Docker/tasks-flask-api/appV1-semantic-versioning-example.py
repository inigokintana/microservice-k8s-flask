from flask import Flask, request, jsonify
from flask_pymongo import PyMongo
from bson.objectid import ObjectId
from flasgger import Swagger,swag_from
import socket
import os

#Flask
app = Flask(__name__)
#mongo
app.config["MONGO_URI"] = "mongodb://mongo:27017/dev"
mongo = PyMongo(app)
db = mongo.db

# Swagger security template
# Define your Swagger template with security definitions
SWAGGER_TEMPLATE = {
    "swagger": "2.0",
    "info": {
        "title": "My Task API",
        "version": "1.0.0",
        "description": "A sample Task API with custom security definitions"
    },
    "securityDefinitions": {
        "APIKeyHeader": {
            "type": "apiKey",
            "name": "x-access-token",
            "in": "header"
        }
    },
    "security": [{"APIKeyHeader": []}]
}

swagger = Swagger(app, template=SWAGGER_TEMPLATE)

# API Key read it from environment - to pass it with docker -e or K8S secret inside a container
env_api_key = os.getenv('API_KEY')

@app.route("/api/v1.0")
@swag_from('./api/v1.0/root.yaml')
def index():
    hostname = socket.gethostname()
    return jsonify(
        message="Welcome to Tasks app! I am running inside {} pod!".format(hostname)
    )
@app.route("/api/v1.0/tasks")
@swag_from('./api/v1.0/tasks.yaml')
def get_all_tasks(): 
    # Extract the API key from the header in the HTTP request
    header_api_key = request.headers.get('x-access-token')
    
    # Here you can add the logic to validate the API key
    if not header_api_key or header_api_key != env_api_key:
        return jsonify({"message": "Unauthorized"}), 401
    
    tasks = db.task.find()
    data = []
    for task in tasks:
        item = {
            "id": str(task["_id"]),
            "task": task["task"]
        }
        data.append(item)
    return jsonify(
        data=data
    )
@app.route("/api/v1.0/task", methods=["POST"])
@swag_from('./api/v1.0/task.yaml')
def create_task():
    # Extract the API key from the header in the HTTP request
    header_api_key = request.headers.get('x-access-token')
    
    # Here you can add the logic to validate the API key
    if not header_api_key or header_api_key != env_api_key:
        return jsonify({"message": "Unauthorized"}), 401
    
    data = request.get_json(force=True)
    db.task.insert_one({"task": data["task"]})
    return jsonify(
        message="Task saved successfully!"
    )
@app.route("/api/v1.0/task/<id>", methods=["PUT"])
@swag_from('./api/v1.0/task-id-put.yaml')
def update_task(id):
    # Extract the API key from the header in the HTTP request
    header_api_key = request.headers.get('x-access-token')
    
    # Here you can add the logic to validate the API key
    if not header_api_key or header_api_key != env_api_key:
        return jsonify({"message": "Unauthorized"}), 401
    
    data = request.get_json(force=True)["task"]
    response = db.task.update_one({"_id": ObjectId(id)}, {"$set": {"task": data}})
    if response.matched_count:
        message = "Task updated successfully!"
    else:
        message = "No Task found!"
    return jsonify(
        message=message
    )
@app.route("/api/v1.0/task/<id>", methods=["DELETE"])
@swag_from('./api/v1.0/task-id-del.yaml')
def delete_task(id):
    # Extract the API key from the header in the HTTP request
    header_api_key = request.headers.get('x-access-token')
    
    # Here you can add the logic to validate the API key
    if not header_api_key or header_api_key != env_api_key:
        return jsonify({"message": "Unauthorized"}), 401
    
    response = db.task.delete_one({"_id": ObjectId(id)})
    if response.deleted_count:
        message = "Task deleted successfully!"
    else:
        message = "No Task found!"
    return jsonify(
        message=message
    )
@app.route("/api/v1.0/tasks/delete", methods=["POST"])
@swag_from('./api/v1.0/task-del-all.yaml')
def delete_all_tasks():
    # Extract the API key from the header in the HTTP request
    header_api_key = request.headers.get('x-access-token')
    
    # Here you can add the logic to validate the API key
    if not header_api_key or header_api_key != env_api_key:
        return jsonify({"message": "Unauthorized"}), 401
    
    db.task.remove()
    return jsonify(
        message="All Tasks deleted!"
    )
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)