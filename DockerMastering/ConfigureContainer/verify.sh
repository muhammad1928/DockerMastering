#!/bin/bash
# Step 1: Verify that the bridge network 'my_bridge_network' exists
echo "Verifying bridge network creation..."
if docker network ls | grep -q "my_bridge_network"; then
    echo "✅ Network 'my_bridge_network' exists."
else
    echo "❌ Network 'my_bridge_network' does not exist."
    exit 1
fi

# Step 2: Verify that the Nginx and Redis containers are running on 'my_bridge_network'
echo "Verifying containers on the network..."
if docker network inspect my_bridge_network | grep -q "web_server"; then
    echo "✅ Container 'web_server' is connected to 'my_bridge_network'."
else
    echo "❌ Container 'web_server' is not connected to 'my_bridge_network'."
    exit 1
fi

if docker network inspect my_bridge_network | grep -q "redis_db"; then
    echo "✅ Container 'redis_db' is connected to 'my_bridge_network'."
else
    echo "❌ Container 'redis_db' is not connected to 'my_bridge_network'."
    exit 1
fi

# Step 3: Verify that the 'web_server' container can ping 'redis_db'
echo "Testing communication between 'web_server' and 'redis_db'..."
docker exec web_server ping -c 2 redis_db > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "'✅ web_server' can reach 'redis_db' over the network."
else
    echo "'❌ web_server' cannot reach 'redis_db'. Network communication failed."
    exit 1
fi


echo "All verifications passed!"
exit 0
