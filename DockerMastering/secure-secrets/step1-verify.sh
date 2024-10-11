#!/bin/bash

if docker run --rm -e MY_SECRET="super-secret" env-demo | grep -q "The secret is super-secret"; then
    exit 0
else
    echo "Environment variable was not set correctly."
    exit 1
fi
