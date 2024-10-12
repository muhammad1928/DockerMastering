# Handling Secrets and Environment Variables in Docker (Local Environment)

In this tutorial, you will learn how to securely manage sensitive information in Docker using environment variables. We'll cover how to pass environment variables to Docker containers and demonstrate a basic local setup for secret management.

## Step 1: Passing Environment Variables to Docker

1. Create a simple `Dockerfile` that uses environment variables:

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

3. Verify that the container outputs the value of `MY_SECRET`:

    Expected output:

    ```bash
    The secret is super-secret
    ```

## Step 2: Simulating Secret Management Locally with Environment Variables

While Docker Swarm supports proper secret management, in a local setup, we can securely manage sensitive information using environment variables.

1. Create a `docker-compose.yml` file to simulate secrets with environment variables:

    ```yaml
    version: "3.7"
    services:
      secret-demo:
        image: env-demo
        environment:
          MY_SECRET: "${MY_SECRET_ENV}"
    ```

2. Set the environment variable `MY_SECRET_ENV` before running the service. This will simulate a "secret" being injected into the container:

    ```bash
    export MY_SECRET_ENV="super-secret-value"
    ```

3. Run the Docker Compose service:

    ```bash
    docker-compose up --build
    ```

4. Verify that the secret is passed into the container by checking the logs:

    ```bash
    docker-compose logs
    ```

    Expected output:

    ```bash
    secret-demo_1  | The secret is super-secret-value
    ```
