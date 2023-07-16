#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

# Step 1:
# Create docker_path (username)
docker_path=de150191


# Step 2:  
# Authenticate & tag
# echo "Docker ID and Image: $docker_path"
docker login

# Check if the image is already tagged and remove it if necessary
image_tagged=$(docker image list --filter=reference="$docker_path/project-ml" | grep 'project-ml' | xargs)
if [[ -n $image_tagged ]]; then
  echo "Image already tagged, remove the tagged image."
  # Extract the image name from the tagged image information
  name=$(echo "$image_tagged" | cut -f 1 -d " ")
  # Extract the image tag from the tagged image information
  tag=$(echo "$image_tagged" | cut -f 2 -d " ")
  # Remove the tagged image forcefully
  docker image remove --force "$name":"$tag"
fi

# Get information about the image by substring 
image_info=$(docker image list | grep 'project-ml' | xargs)
# Extract the image name from the image information
image_name=$(echo "$image_info" | cut -f 1 -d " ")
# Extract the image tag from the image information
image_tag=$(echo "$image_info" | cut -f 2 -d " ")

# Tag the image with the specified repository and tag
docker image tag "$image_name:$image_tag" "$docker_path/$image_name:$image_tag"

# List the tagged image
docker image list --filter=reference="$docker_path/project-ml"

# Step 3:
# Push image to a docker repository
# Push the tagged image to the Docker repository
docker image push "$docker_path/project-ml:$image_tag"
