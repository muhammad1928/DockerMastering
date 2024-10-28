#!/bin/bash

response=$(echo $MY_SECRET_ENV)
expected_value="super-secret-value"

if [[ "$response" == "$expected_value" ]]; then
  exit 0
else
  exit 1
fi
