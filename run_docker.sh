#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
# Tag version for building with v1.0.0 to push it in dockerhub
docker build --tag project-ml:v1.0.0 .

# Step 2: 
# List docker images
# List out to all docker images in enviroment
docker image list

# Step 3:
# Run flask app
# Run docker images project-ml:v1.0.0 and expose to port 8000 in host machine
docker run --detach --publish 8000:80 project-ml:v1.0.0
