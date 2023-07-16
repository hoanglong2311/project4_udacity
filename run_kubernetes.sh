#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
docker_path=de150191

# Step 2
# Create a deployment in Kubernetes with the specified image
# create that deployment with given name of docker_path and version docker images
kubectl create deploy udacity-project4-microservice-for-machineLN --image="$docker_path/project-ml:v1.0.2"


# Step 3:
# List kubernetes pods
# Get all pod in kubernetes includ runing or not 
kubectl get pods

# Step 4:
# Forward the container port to a host

kubectl port-forward deployment.apps/udacity-project4-microservice-for-machineLN 8000:80
