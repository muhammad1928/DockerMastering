#!/bin/bash

# Step 1: Check if the Docker image 'my-nginx-image' exists
IMAGE_NAME="my-nginx-image"
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
    echo "❌ Docker image '$IMAGE_NAME' not found. Please build the image first."
    exit 1
else
    echo "✅ Docker image '$IMAGE_NAME' exists."
fi

# Step 2: Check if the Docker container 'my-nginx-container' is running
CONTAINER_NAME="my-nginx-container"
if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]]; then
    echo "❌ Docker container '$CONTAINER_NAME' is not running. Please run the container."
    exit 1
else
    echo "✅ Docker container '$CONTAINER_NAME' is running."
fi

# Step 3: Test if the web server is accessible at http://localhost:8080
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [[ "$RESPONSE" -ne 200 ]]; then
    echo "❌ Web server not reachable at http://localhost:8080."
    exit 1
else
    echo "✅ Web server is reachable at http://localhost:8080."
fi

echo "🎉 All checks passed! Your Docker container is running correctly."
