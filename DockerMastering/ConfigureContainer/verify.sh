#!/bin/bash
# Step 1: Verify that the bridge network 'my-bridge-network' exists
echo "Verifying bridge network creation..."
if docker network ls | grep -q "my-bridge-network"; then
    echo "✅ Network 'my-bridge-network' exists."
    exit 0
else
    echo "❌ Network 'my-bridge-network' does not exist."
    exit 1
fi

# Step 2: Verify that the Nginx and Redis containers are running on 'my-bridge-network'
echo "Verifying containers on the network..."
if docker network inspect my-bridge-network | grep -q "web-server"; then
    echo "✅ Container 'web-server' is connected to 'my-bridge-network'."
    exit 0
else
    echo "❌ Container 'web-server' is not connected to 'my-bridge-network'."
    exit 1
fi

if docker network inspect my-bridge-network | grep -q "redis_db"; then
    echo "✅ Container 'redis_db' is connected to 'my-bridge-network'."
    exit 0
else
    echo "❌ Container 'redis_db' is not connected to 'my-bridge-network'."
    exit 1
fi

# Step 3: Verify that the 'web-server' container can ping 'redis_db'
echo "Testing communication between 'web-server' and 'redis_db'..."
docker exec web-server ping -c 2 redis_db > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "'✅ web-server' can reach 'redis_db' over the network."
    exit 0
else
    echo "'❌ web-server' cannot reach 'redis_db'. Network communication failed."
    exit 1
fi


echo "All verifications passed!"

