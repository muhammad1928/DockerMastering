# Step 3: Combining Environment Variables and Docker Secrets

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
