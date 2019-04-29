#!/bin/sh
docker push shuxs/ossfs:latest
docker push shuxs/aspnet:ossfs
docker push shuxs/jre:ossfs

exit 0

docker pull shuxs/ossfs:latest
docker pull shuxs/aspnet:ossfs
docker pull shuxs/jre:ossfs
