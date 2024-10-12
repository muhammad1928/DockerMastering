#!/bin/bash

if docker images | grep -q "optimized-image"; then
    if docker images | grep -q "basic-image"; then
        exit 0
    else
        echo "Basic Docker image not found. Make sure you have built the image correctly."
        exit 1
    fi
else
    echo "Optimized Docker image not found. Make sure you have built the optimized image correctly."
    exit 1
fi
