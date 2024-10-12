#!/bin/bash
docker inspect hello-world-container | grep -q '"NetworkMode": "hello-world-network"' && echo "Container is on the custom network." || echo "Container is not on the custom network."
