#!/bin/bash

if docker service logs $(docker service ps -q --filter "desired-state=running" combined-demo) | grep -q "my-sensitive-data"; then
    exit 0
else
    echo "Docker secret was not accessed correctly."
    exit 1
fi
