#!/bin/bash

# Step 1: Check if the Docker volume 'my_data_volume' exists
VOLUME_NAME="my-data-volume"
if [[ "$(docker volume ls -q -f name=$VOLUME_NAME)" == "" ]]; then
    echo "❌ Docker volume '$VOLUME_NAME' not found. Please create the volume first."
    exit 1
else
    echo "✅ Docker volume '$VOLUME_NAME' exists."
    exit 0
fi

# Step 2: Check if the Docker container 'my_nginx' is running with the volume mounted
CONTAINER_NAME="my-nginx"
if [[ "$(docker ps -q -f name=$CONTAINER_NAME)" == "" ]]; then
    echo "❌ Docker container '$CONTAINER_NAME' is not running. Please run the container with the volume."
    exit 1
else
    echo "✅ Docker container '$CONTAINER_NAME' is running."
    exit 0
fi

# Step 3: Check if the data is added to the volume
EXPECTED_CONTENT="<h1>Hello from the persistent volume!</h1>"
ACTUAL_CONTENT=$(docker exec $CONTAINER_NAME cat /usr/share/nginx/html/index.html 2> /dev/null)
if [[ "$ACTUAL_CONTENT" == "$EXPECTED_CONTENT" ]]; then
    echo "✅ Data exists in the volume and is correctly mounted in the container."
    exit 0
else
    echo "❌ The content in the volume does not match the expected content."
    exit 1
fi

# Step 4: Test the web server's response on http://localhost:8080
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080)
if [[ "$RESPONSE" -ne 200 ]]; then
    echo "❌ Web server is not reachable at http://localhost:8080."
    exit 1
else
    echo "✅ Web server is reachable at http://localhost:8080 and serving content from the volume."
    exit 0
fi


echo "🎉 All checks passed! Your Docker volume setup and data persistence are correct."
