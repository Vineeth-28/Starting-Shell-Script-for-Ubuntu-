#!/bin/bash

IMAGE_NAME="vineet2804/myapp"

docker build -t $IMAGE_NAME .

docker push $IMAGE_NAME

echo "Docker image pushed"