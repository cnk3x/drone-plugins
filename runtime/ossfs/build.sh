#!/bin/sh
docker build -t shuxs/ossfs:latest -f ossfs.Dockerfile . && docker push shuxs/ossfs:latest
docker build -t shuxs/aspnet:ossfs -f aspnet-ossfs.Dockerfile . && docker push shuxs/aspnet:ossfs
docker build -t shuxs/jre:ossfs -f jre-ossfs.Dockerfile . && docker push shuxs/jre:ossfs
