#!/bin/bash

# Use curl to get the content from localhost
response=$(curl -s http://localhost:8080)

# Expected content from the index.html file
expected_content="<!DOCTYPE html><html><body><h1>Welcome to Docker Compose</h1></body></html>"

# Check if the response matches the expected content
if [[ "$response" == "$expected_content" ]]; then
  echo "Verification successful: Web server is serving the correct content."
  exit 0
else
  echo "Verification failed: Web server is not serving the correct content."
  echo "Hint: Make sure Docker Compose is running correctly. Try running:"
  echo "docker-compose up"
  exit 1
fi
