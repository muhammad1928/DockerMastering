#!/bin/bash
grep -q "FROM alpine:latest" Dockerfile && echo "Dockerfile created successfully." || echo "Dockerfile creation failed."
