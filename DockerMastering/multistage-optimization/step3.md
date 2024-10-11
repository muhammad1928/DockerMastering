# Step 3: Compare the Results

1. List the sizes of both images to compare:

    ```bash
    docker images | grep -E "basic-image|optimized-image"
    ```

2. Explain why the multi-stage build reduced the image size:
   - The builder stage included unnecessary files that were not copied to the final stage.
   - The final image only contains the essential files, making it significantly smaller.

Congratulations! You've successfully optimized a Docker image using a multi-stage build.
