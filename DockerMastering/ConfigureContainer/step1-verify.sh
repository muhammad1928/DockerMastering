#!/bin/bash
docker network ls | grep -q "hello-world-network" && echo "Network created successfully." || echo "Network creation failed."
