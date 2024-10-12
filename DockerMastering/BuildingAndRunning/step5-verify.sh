#!/bin/bash
docker ps | grep -q "hello-world-container" && echo "Container is running." || echo "Container failed to start."
