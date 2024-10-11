# Step 2: Using Docker Secrets for Secure Management

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
