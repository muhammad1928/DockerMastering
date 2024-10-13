#!/bin/bash

# Step 1: Check if the directory and Dockerfile exist
DIRECTORY="my-docker-project"
DOCKERFILE_PATH="$DIRECTORY/Dockerfile"

if [[ ! -d "$DIRECTORY" || ! -f "$DOCKERFILE_PATH" ]]; then
    echo "❌ Directory '$DIRECTORY' or Dockerfile not found. Please follow Step 1 and Step 2 to set up the project and create the Dockerfile."
    exit 1
else
    echo "✅ Directory and Dockerfile found."
fi

# Step 2: Check if the HTML file exists
HTML_FILE_PATH="$DIRECTORY/index.html"
if [[ ! -f "$HTML_FILE_PATH" ]]; then
    echo "❌ HTML file 'index.html' not found in '$DIRECTORY'. Please create the HTML file."
    exit 1
else
    echo "✅ HTML file 'index.html' found."
fi

# Step 3: Build the Docker image
IMAGE_NAME="my-nginx-image"
docker build -t $IMAGE_NAME $DIRECTORY
if [[ "$(docker images -q $IMAGE_NAME)" == "" ]]; then
    echo "❌ Docker image '$IMAGE_NAME' failed to build."
    exit 1
else
    echo "✅ Docker image '$IMAGE_NAME' built successfully."
fi

# Step 4: Run the Docker container
CONTAINER_NAME="my-nginx-container"
docker run -d -p 8080:80 --name $CONTAINER_NAME $IMAGE_NAME
if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]]; then
    echo "❌ Docker container '$CONTAINER_NAME' failed to start."
    exit 1
else
    echo "✅ Docker container '$CONTAINER_NAME' is running."
fi

# Step 5: Test the web server's response at http://localhost:8080
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [[ "$RESPONSE" -ne 200 ]]; then
    echo "❌ Web server is not reachable at http://localhost:8080."
    exit 1
else
    echo "✅ Web server is reachable at http://localhost:8080."
fi

# Step 6: Verify the HTML content served by the web server
EXPECTED_CONTENT="<h1>Hello, Docker!</h1>"
ACTUAL_CONTENT=$(curl -s http://localhost:8080 | grep -o "$EXPECTED_CONTENT")
if [[ "$ACTUAL_CONTENT" == "$EXPECTED_CONTENT" ]]; then
    echo "✅ The HTML content served by the web server is correct."
else
    echo "❌ The HTML content served by the web server is incorrect."
    exit 1
fi

# Step 7: Clean up - Stop and remove the container
docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME
echo "✅ Docker container cleaned up."

echo "🎉 All checks passed! Your Docker container is set up and running correctly with the custom HTML content."
