#!/usr/bin/env bash

function checkRet() {
    if [[ "$1" != "0" ]]; then
        exit $1
    fi
}

docker build -t shuxs/alpine4net:latest -f alpine4net.Dockerfile .
checkRet $?

docker images | grep shuxs/alpine4net | grep none | awk '{print $3}' | xargs -I {} docker rmi {}

docker push shuxs/alpine4net:latest
checkRet $?

docker build -t shuxs/aspnet:latest -t shuxs/aspnet:2.2.4 -f aspnet.Dockerfile .
checkRet $?

docker images | grep shuxs/aspnet | grep none | awk '{print $3}' | xargs -I {} docker rmi {}
docker push shuxs/aspnet

docker run --rm shuxs/aspnet:2.2.4
