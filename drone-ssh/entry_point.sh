#!/bin/sh

echo 启动镜像

host=${PLUGIN_HOST}
port=${PLUGIN_PORT}
user=${PLUGIN_USER}
key=${PLUGIN_KEY}
name=${PLUGIN_NAME}
publish=${PLUGIN_PUBLISH}
network=${PLUGIN_NETWORK}
runAt=${PLUGIN_RUN_AT_HOSTNAME}
server_port=${PLUGIN_SERVER_PORT}

VERSION=$(cat VERSION)
if [[ -z "${VERSION}" ]]; then
    echo "读取版本号失败."
    exit 1
fi
echo VERSION:${VERSION}

tag=${PLUGIN_REGISTRY}/${PLUGIN_NAMESPACE}/java-${name}:${VERSION}

mkdir -p ~/.ssh
echo "-----BEGIN RSA PRIVATE KEY-----" >~/.ssh/id_rsa
echo ${key} >>~/.ssh/id_rsa
echo "-----END RSA PRIVATE KEY-----" >>~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa && cat ~/.ssh/id_rsa
ssh -i ~/.ssh/id_rsa -l ${user} -p ${port} -o StrictHostKeyChecking=no ${host} "\
docker login --username=${PLUGIN_USERNAME} --password=${PLUGIN_PASSWORD} ${PLUGIN_REGISTRY}; \
docker pull ${tag}; \
docker service create \
--detach \
--name=java-${name} \
--network=${network} \
--publish=${publish}:${server_port} \
--limit-cpu=0.5 \
--limit-memory=4294967296 \
--config=source=java-${name}.config,target=/app.config \
--constraint='node.hostname == ${runAt}' \
${tag};"
