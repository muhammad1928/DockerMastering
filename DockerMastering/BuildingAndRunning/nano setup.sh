#!/bin/bash

# Create project directory
mkdir -p my-docker-project
cd my-docker-project

# Automatically generate Dockerfile with specified content
cat <<EOL > Dockerfile
# Use the official Nginx image as the base image
FROM nginx:latest

# Copy a custom index.html file to the default Nginx directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to allow external access
EXPOSE 80
EOL

# Create and populate the index.html file
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Docker Nginx Server</title>
</head>
<body>
    <h1>Hello, Docker!</h1>
    <p>This is a simple web page served by an Nginx container.</p>
</body>
</html>
EOF

echo "Dockerfile and index.html have been created successfully in my-docker-project/"


chmod +x setup.sh
