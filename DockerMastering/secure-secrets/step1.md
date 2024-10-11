# Step 1: Passing Environment Variables to Docker

1. Create a simple Dockerfile that uses environment variables:

    ```dockerfile
    # Dockerfile
    FROM ubuntu:latest

    # Set a default environment variable
    ENV MY_SECRET="default-secret"

    # Print the environment variable
    CMD echo "The secret is $MY_SECRET"
    ```

2. Build and run the Docker container with a custom environment variable:

    ```bash
    docker build -t env-demo .
    docker run --rm -e MY_SECRET="super-secret" env-demo
    ```

3. Verify that the container outputs the value of `MY_SECRET`.
