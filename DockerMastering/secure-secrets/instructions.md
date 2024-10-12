# Handling Secrets and Environment Variables in Docker

In this scenario, you will learn how to securely manage sensitive information in Docker. We will cover:

1. Passing environment variables to Docker containers.
2. Using Docker secrets for secure secret management.
3. Combining environment variables and Docker secrets in a Docker Compose setup.

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

3. Verify that the container outputs the value of `MY_SECRET`.

    Expected output:
    ```bash
    The secret is super-secret
    ```

---

## Step 2: Using Docker Secrets for Secure Management

We’ll now move on to using Docker Secrets, ensuring it's as simple as possible.

1. **Initialize Docker Swarm (only needs to be done once):**

    ```bash
    docker swarm init
    ```

2. **Create a Docker secret:**

    ```bash
    echo "my-sensitive-data" | docker secret create my_docker_secret -
    ```

3. **Update the `Dockerfile` to read from the secret:**

    ```dockerfile
    # Dockerfile
    FROM ubuntu:latest

    # Read the secret from the file mounted by Docker
    CMD cat /run/secrets/my_docker_secret || echo "Secret not found"
    ```

4. **Create a simple `docker-compose.yml` file to use the secret:**

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

5. **Deploy the stack using Swarm (instead of using `docker-compose up`):**

    ```bash
    docker stack deploy -c docker-compose.yml my_stack
    ```

6. **Check the logs to verify that the secret is accessible:**

    ```bash
    docker service logs my_stack_secret-demo
    ```

    Expected output:

    ```bash
    my-sensitive-data
    ```

---

## Step 3: Combining Environment Variables and Docker Secrets

We will now combine both environment variables and Docker secrets.

1. **Update the `docker-compose.yml` to use both environment variables and secrets:**

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

2. **Update the `Dockerfile` to print both the environment variable and the Docker secret:**

    ```dockerfile
    # Dockerfile
    FROM ubuntu:latest

    CMD echo "Environment Variable: $ENV_SECRET" && cat /run/secrets/my_docker_secret || echo "Secret not found"
    ```

3. **Run the service with the environment variable:**

    ```bash
    MY_ENV_SECRET="environment-secret" docker stack deploy -c docker-compose.yml my_stack
    ```

4. **Check the logs to verify both the environment variable and the secret are displayed:**

    ```bash
    docker service logs my_stack_combined-demo
    ```

    Expected output:

    ```bash
    Environment Variable: environment-secret
    my-sensitive-data
    ```
