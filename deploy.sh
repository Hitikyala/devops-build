#!/bin/bash

# Stop and remove any existing container
docker stop dev || true
docker rm dev || true

# Push the image to the dev repository
docker login -u hitikyala -p "$DOCKER_PASS"
docker push hitikyala/dev:latest

# Run the new container
docker run -d --name dev -p 80:80 hitikyala/dev:latest
