#!/bin/bash

# Fetch the logs of the running container
log_output=$(docker-compose logs 2>/dev/null)

# Expected secret value
expected_secret="super-secret-value"

# Check if the expected secret value is present in the logs
if echo "$log_output" | grep -q "The secret is $expected_secret"; then
  echo "Verification successful: The secret is correctly passed to the container."
  exit 0
else
  echo "Verification failed: The secret is not correctly passed."
  echo "Hint: Ensure that you've set the environment variable MY_SECRET_ENV before running the service."
  echo "Try running: export MY_SECRET_ENV=\"super-secret-value\" and then docker-compose up --build"
  exit 1
fi
