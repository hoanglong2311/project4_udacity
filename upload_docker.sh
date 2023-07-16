#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create docker_path (username)
docker_path=de150191


# Step 2:  
# Login in docker hub with user name and password its store before
docker login

# Check if the image is already tagged and remove it if necessary

# Check if the image with the specified reference is already tagged
image_tagged=$(docker image list --filter=reference="$docker_path/project-ml" | grep 'project-ml' | xargs)

# If the image is already tagged, remove the tagged image
if [[  -n $image_tagged  ]]; then

# print out this image is already tagged in docker hub and will be remove tag name
  echo "Image already tagged, remove the tagged image."

  # Extract the image name from the tagged image information
  name=$(echo "$image_tagged")
  # Cut strung in name when get from image_tagged
  name=$(echo "$name" | cut -f 1 -d " ")

  # Extract the image tag from the tagged image information
  tag=$(echo "$image_tagged")
  # Cut String for tag from image_tagged to create a new tag
  tag=$(echo "$tag" | cut -f 2 -d " ")

  # Remove the tagged image forcefully
  docker image remove --force "$name":"$tag"
fi


# Get information about the image by filters the lines containing "project-ml, only the lines representing Docker images with "project-ml" in their names.
image_info=$(docker image list | grep 'project-ml' | xargs)

# Extracts the image name from the image_info variable from above processing. 
image_name=$(echo "$image_info")
#Substring for image name from image_info
image_name=$(echo "$image_name" | cut -f 1 -d " ")

# Extracts the image tag from the image_info variable from above processing.
image_tag=$(echo "$image_info")
#Substring for image tag from image_info
image_tag=$(echo "$image_tag" | cut -f 2 -d " ")

# Create tag and taged for images before it push to doicker hub
docker image tag "$image_name:$image_tag" "$docker_path/$image_name:$image_tag"

# Step 3:
# Push image to a docker repository
# Push docker image to dockerhub to store and share
docker image push "$docker_path/project-ml:$image_tag"
