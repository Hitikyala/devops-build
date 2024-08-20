#!/bin/bash

# Stop and remove any existing container
docker stop dev || true
docker rm dev || true

# Push the image to the dev repository
docker login -u hitikyala -p "$DOCKER_TOKEN"
docker push hitikyala/dev:latest

# Run the new container
docker run -d -p 80:80 --name hitikyala/dev:latest
