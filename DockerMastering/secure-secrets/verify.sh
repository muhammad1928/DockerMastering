#!/bin/bash

if docker-compose logs | grep -q "The secret is super-secret-value"; then
  echo "Verification successful: Secret is correctly passed to the container."
  exit 0
else
  echo "Verification failed: Secret not found in the container logs."
  exit 1
fi
