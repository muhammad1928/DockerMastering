#!/bin/bash

if docker images | grep -q "optimized-image"; then
    exit 0
else
    echo "Optimized Docker image not found. Make sure you have built the optimized image correctly."
    exit 1
fi
