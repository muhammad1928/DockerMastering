#!/bin/bash

# Step 1: Check if the Docker container 'web' is running
if docker ps; then
    echo "❌ Docker container '$CONTAINER_NAME' is not running. Please start the container first."
    exit 0
else
    echo "✅ Docker container '$CONTAINER_NAME' is running."
    exit 1
fi

# Step 2: Check if the container is marked as healthy
HEALTHY_STATUS="healthy"
CURRENT_STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_NAME" 2>/dev/null)
if [[ "$CURRENT_STATUS" == "$HEALTHY_STATUS" ]]; then
    echo "✅ Container '$CONTAINER_NAME' is healthy."
else
    echo "❌ Container '$CONTAINER_NAME' is not healthy. Current status: $CURRENT_STATUS."
    exit 1
fi

# Step 3: Simulate a failure by hitting the /fail endpoint
echo "Simulating a failure by accessing the /fail endpoint..."
curl -s http://localhost:5000/fail > /dev/null

# Step 4: Check if the container becomes unhealthy
UNHEALTHY_STATUS="unhealthy"
MAX_RETRIES=10
SLEEP_INTERVAL=5

for i in $(seq 1 $MAX_RETRIES); do
    CURRENT_STATUS=$(docker inspect --format='{{.State.Health.Status}}' "$CONTAINER_NAME")
    echo "Attempt $i/$MAX_RETRIES: Current status: $CURRENT_STATUS"

    if [[ "$CURRENT_STATUS" == "$UNHEALTHY_STATUS" ]]; then
        echo "✅ Container '$CONTAINER_NAME' is marked as unhealthy as expected."
        break
    fi

    if [[ $i -eq $MAX_RETRIES ]]; then
        echo "❌ Container '$CONTAINER_NAME' did not become unhealthy after failure. Exiting."
        exit 1
    fi

    sleep $SLEEP_INTERVAL
done

# Step 5: Test the web server's response on http://localhost:5000
RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:5000)
if [[ "$RESPONSE" -ne 200 ]]; then
    echo "❌ Web server is not reachable at http://localhost:5000 or is not serving correctly."
    exit 1
else
    echo "✅ Web server is reachable at http://localhost:5000."
fi

echo "🎉 All checks passed! Your Docker container setup and health check configuration are correct."
