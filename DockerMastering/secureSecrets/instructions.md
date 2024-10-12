# Handling Secrets and Environment Variables in Docker

In this scenario, you will learn how to securely manage sensitive information in Docker. We will cover:

1. Passing environment variables to Docker containers.
2. Using Docker secrets for secure secret management.
3. Combining environment variables and Docker secrets in a Docker Compose setup.

You will also learn about the security risks associated with using environment variables and how Docker secrets can help mitigate these risks.

## Step 1: Passing Environment Variables to Docker

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

## Step 2: Using Docker Secrets for Secure Management

1. Initialize Docker Swarm if it isn't already:

    ```bash
    docker swarm init
    ```

2. Create a secret named `my_docker_secret`:

    ```bash
    echo "my-sensitive-data" | docker secret create my_docker_secret -
    ```

3. Update the Dockerfile to access the secret:

    ```dockerfile
    # Dockerfile
    FROM ubuntu:latest

    # Read the secret from the file mounted by Docker
    CMD cat /run/secrets/my_docker_secret
    ```

4. Create a `docker-compose.yml` file to use the secret:

    ```yaml
    version: "3.7"
    services:
      secret-demo:
        image: secret-demo
        build: .
        secrets:
          - my_docker_secret

    secrets:
      my_docker_secret:
        external: true
    ```

5. Build and run the service:

    ```bash
    docker-compose up --build
    ```

The container should output the contents of the secret.

## Step 3: Combining Environment Variables and Docker Secrets

1. Update the `docker-compose.yml` file to use both environment variables and secrets:

    ```yaml
    version: "3.7"
    services:
      combined-demo:
        image: combined-demo
        build: .
        environment:
          - ENV_SECRET=${MY_ENV_SECRET}
        secrets:
          - my_docker_secret

    secrets:
      my_docker_secret:
        external: true
    ```

2. Update the `Dockerfile` to print both the environment variable and the Docker secret:

    ```dockerfile
    # Dockerfile
    FROM ubuntu:latest

    CMD echo "Environment Variable: $ENV_SECRET" && cat /run/secrets/my_docker_secret
    ```

3. Run the service with the environment variable:

    ```bash
    MY_ENV_SECRET="environment-secret" docker-compose up --build
    ```

4. Verify that both the environment variable and the Docker secret are correctly displayed.
