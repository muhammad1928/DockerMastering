# Step 1: Create a Basic Docker Image

1. Create a file named `Dockerfile` with the following content:

    ```dockerfile
    # Basic Dockerfile
    FROM ubuntu:latest

    # Install some packages
    RUN apt-get update && \
        apt-get install -y curl vim && \
        apt-get clean

    # Set working directory
    WORKDIR /app
    ```

2. Build the Docker image:

    ```bash
    docker build -t basic-image .
    ```

3. Check the size of the created image:

    ```bash
    docker images | grep basic-image
    ```

You should see the size of the `basic-image` displayed in the output.
