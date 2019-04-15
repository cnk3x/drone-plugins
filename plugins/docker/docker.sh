#!/bin/sh

function checkRet() {
    code=$1
    title=$2
    if [[ ${code} == 0 ]]; then
        echo "${title} 成功"
    else
        echo "${title} 失败,退出代码:${code}"
        exit ${code}
    fi
}

DOCKER_USERNAME=${PLUGIN_USERNAME}
DOCKER_PASSWORD=${PLUGIN_PASSWORD}
DOCKER_REGISTRY=${PLUGIN_REGISTRY}
DOCKER_NAMESPACE=${PLUGIN_NAMESPACE}
DOCKER_REPO_NAME=${PLUGIN_REPO_NAME}

echo "检查版本号"
VERSION=$(cat VERSION)
if [[ -z "${VERSION}" ]]; then
    echo "读取版本号失败."
    exit 1
else
    echo VERSION:${VERSION}
fi

echo "检查 docker 命令"
if [[ -x "/usr/bin/docker" ]]; then
    echo "docker 存在."
else
    echo "docker 不存在."
    exit 1
fi

echo "检查 docker 是否运行"
if [[ -S "/var/run/docker.sock" ]]; then
    echo "docker 已启动."
else
    echo "docker 未运行."
    exit 1
fi

section="登录镜像仓库"
echo ${section}
docker login --username=${DOCKER_USERNAME} --password=${DOCKER_PASSWORD} ${DOCKER_REGISTRY}
checkRet $? "${section}"

cp /goapp.Dockerfile Dockerfile

REPO=${DOCKER_REGISTRY}/${DOCKER_NAMESPACE}/${DOCKER_REPO_NAME}
section="编译镜像 ${REPO}"
echo ${section}
docker build --tag ${REPO}:${VERSION} --build-arg JAR=${jar} .
checkRet $? "${section}"

section="发布镜像 ${REPO}:${VERSION}"
echo ${section}
docker push ${REPO}:${VERSION}
checkRet $? "${section}"

section="清理镜像 ${REPO}:${VERSION}"
echo ${section}
docker image rm ${REPO}:${VERSION}
checkRet $? "${section}"

# for app in ${DIST}; do
#     name=$(basename ${app})
#     jar=$(dirname ${app})-${VERSION}.jar
#     if [[ -f ${jar} ]]; then
#         tag=${PLUGIN_REGISTRY}/${PLUGIN_NAMESPACE}/java-${name}

#         section="编译镜像 ${tag}:${VERSION} + latest"
#         echo ${section}
#         docker build --tag ${tag}:${VERSION} --build-arg JAR=${jar} .
#         checkRet $? "${section}"

#         section="发布镜像 ${tag}:${VERSION}"
#         echo ${section}
#         docker push ${tag}:${VERSION}
#         checkRet $? "${section}"

#         section="清理"
#         echo ${section}
#         docker image rm ${tag}:latest ${tag}:${VERSION}
#         checkRet $? "${section}"
#     else
#         echo 目标文件不存在 ${jar}
#         exit 1
#     fi
# done
