#!/bin/bash

# Step 1: Check if the 'my-docker-project' directory exists
DIRECTORY="my-docker-project"
if [ ! -d "$DIRECTORY" ]; then
    echo "❌ Directory '$DIRECTORY' not found. Please create the directory first."
    exit 1
else
    echo "✅ Directory '$DIRECTORY' exists."
fi

# Step 2: Check if the Dockerfile exists and contains the correct content
DOCKERFILE="$DIRECTORY/Dockerfile"
if [ ! -f "$DOCKERFILE" ]; then
    echo "❌ Dockerfile not found in '$DIRECTORY'. Please create the Dockerfile first."
    exit 1
else
    echo "✅ Dockerfile exists."
    # Check Dockerfile content
    if ! grep -q "FROM nginx:latest" "$DOCKERFILE" || \
       ! grep -q "COPY index.html /usr/share/nginx/html/index.html" "$DOCKERFILE" || \
       ! grep -q "EXPOSE 80" "$DOCKERFILE"; then
        echo "❌ Dockerfile content is incorrect. Please ensure it matches the required configuration."
        exit 1
    else
        echo "✅ Dockerfile content is correct."
    fi
fi

# Step 3: Check if the HTML file exists and contains the correct content
HTML_FILE="$DIRECTORY/index.html"
if [ ! -f "$HTML_FILE" ]; then
    echo "❌ index.html file not found in '$DIRECTORY'. Please create the HTML file first."
    exit 1
else
    echo "✅ index.html file exists."
    # Check HTML file content
    if ! grep -q "<h1>Hello, Docker!</h1>" "$HTML_FILE"; then
        echo "❌ index.html content is incorrect. Please ensure it matches the required content."
        exit 1
    else
        echo "✅ index.html content is correct."
    fi
fi

# Step 4: Check if the Docker image 'my-nginx-image' exists
IMAGE_NAME="my-nginx-image"
if [[ "$(docker images -q $IMAGE_NAME 2> /dev/null)" == "" ]]; then
    echo "❌ Docker image '$IMAGE_NAME' not found. Please build the image first."
    exit 1
else
    echo "✅ Docker image '$IMAGE_NAME' exists."
fi

# Step 5: Check if the Docker container 'my-nginx-container' is running
CONTAINER_NAME="my-nginx-container"
if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]]; then
    echo "❌ Docker container '$CONTAINER_NAME' is not running. Please run the container."
    exit 1
else
    echo "✅ Docker container '$CONTAINER_NAME' is running."
fi

# Step 6: Test if the web server is accessible at http://localhost:8080
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [[ "$RESPONSE" -ne 200 ]]; then
    echo "❌ Web server not reachable at http://localhost:8080."
    exit 1
else
    echo "✅ Web server is reachable at http://localhost:8080."
fi

echo "🎉 All checks passed! Your Docker container setup is correct."
