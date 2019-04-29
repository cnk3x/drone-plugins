#!/bin/sh
docker build -t shuxs/ossfs:latest .
docker build -t shuxs/aspnet:ossfs -f aspnet-ossfs.Dockerfile .
docker build -t shuxs/jre:ossfs -f jre-ossfs.Dockerfile .
