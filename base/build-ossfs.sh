#!/bin/sh
docker build \
    -t shuxs/ossfs:latest . &&
    docker push shuxs/ossfs:latest
