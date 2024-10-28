#!/bin/bash

expected_secret="super-secret-value"

if [[ "$MY_SECRET_ENV" == "$expected_secret" ]]; then
  exit 0
else
  exit 1
fi
