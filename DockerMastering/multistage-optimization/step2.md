# Step 2: Optimize the Docker Image with Multi-Stage Build

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
