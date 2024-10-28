#!/bin/bash

if [ "$MY_SECRET_ENV" == "super-secret-value" ]; then
  exit 0
else
  exit 1
fi
