# Introduction to Multi-Stage Docker Builds

In this scenario, you will learn how to optimize Docker images using multi-stage builds. You will start off by creating a basic Docker image with a few installs and then improve it using optimization techniques.

The goal here will be to understand the use of multi-stage builds and how it can dramatically reduce the size of the image.

## Step 1: Create a Basic Docker Image

<!-- This has to be done. -->
First we need to remove previous docker containers
```bash
docker rm -f web-server redis_db app-server
docker network rm my-bridge-network
```
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

## Step 2: Optimize the Docker Image with Multi-Stage Build

1. Update the `Dockerfile` to use a multi-stage build:

    ```dockerfile
    # Multi-stage Dockerfile
    FROM ubuntu:latest as builder

    # Install packages in the builder stage
    RUN apt-get update && \
        apt-get install -y curl vim && \
        apt-get clean

    # Final stage
    FROM ubuntu:latest

    # Copy only what's necessary from the builder stage
    COPY --from=builder /bin/curl /bin/curl
    COPY --from=builder /usr/bin/vim /usr/bin/vim

    # Set working directory
    WORKDIR /app
    ```

2. Build the optimized Docker image:

    ```bash
    docker build -t optimized-image .
    ```

3. Check the size of the optimized image:

    ```bash
    docker images | grep optimized-image
    ```

Notice how the image size has been reduced compared to the original `basic-image`.

## Step 3: Compare the Results

1. List the sizes of both images to compare:

    ```bash
    docker images | grep -E "basic-image|optimized-image"
    ```

2. Explain why the multi-stage build reduced the image size:
   - The builder stage included unnecessary files that were not copied to the final stage.
   - The final image only contains the essential files, making it significantly smaller.

Congratulations! You've successfully optimized a Docker image using a multi-stage build.
