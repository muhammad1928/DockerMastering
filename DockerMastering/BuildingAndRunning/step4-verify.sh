#!/bin/bash
docker images | grep -q "hello-world-image" && echo "Docker image built successfully." || echo "Docker image build failed."
