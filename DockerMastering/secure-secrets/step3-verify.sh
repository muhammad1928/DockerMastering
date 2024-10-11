#!/bin/bash

if docker-compose logs combined-demo | grep -q "Environment Variable: environment-secret" && \
   docker-compose logs combined-demo | grep -q "my-sensitive-data"; then
    exit 0
else
    echo "Either the environment variable or Docker secret was not handled correctly."
    exit 1
fi
