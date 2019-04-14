#!/bin/sh

export PATH=$PATH:/usr/local/maven/bin

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

VERSION=$(cat VERSION)
if [[ -z "${VERSION}" ]]; then
    echo "读取版本号失败."
    exit 1
fi
echo VERSION:${VERSION}

DIST=$(cat DIST)
if [[ -z "${DIST}" ]]; then
    echo "获取目标JAR文件列表失败."
    exit 1
fi
echo DIST:${DIST}

if [[ -x "/usr/bin/docker" ]]; then
    echo "docker 存在."
else
    echo "docker 不存在."
    exit 1
fi

if [[ -S "/var/run/docker.sock" ]]; then
    echo "docker 已启动."
else
    echo "docker 未运行."
    exit 1
fi

section="设置版本号:${VERSION}"
echo ${section}
mvn versions:set -DnewVersion=${VERSION} -B -q && mvn -N versions:update-child-modules -B -q && mvn versions:commit -B -q
checkRet $? "${section}"

section="编译项目"
echo ${section}
mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true -B -q
checkRet $? "${section}"

section="登录镜像仓库"
echo ${section}
docker login --username=${PLUGIN_USERNAME} --password=${PLUGIN_PASSWORD} ${PLUGIN_REGISTRY}
checkRet $? "${section}"

cp /java.Dockerfile Dockerfile

for app in ${DIST}; do
    name=$(basename ${app})
    jar=${app}-${VERSION}.jar
    if [[ -f ${jar} ]]; then
        tag=${PLUGIN_REGISTRY}/${PLUGIN_NAMESPACE}/java-${name}

        section="编译镜像 ${tag}:${VERSION} + latest"
        echo ${section}
        docker build \
            --tag ${tag}:${VERSION} \
            --tag ${tag}:latest \
            --build-arg JAR=${jar} .
        checkRet $? "${section}"

        section="发布镜像 ${tag}:${VERSION}"
        echo ${section}
        docker push ${tag}:latest && docker push ${tag}:${VERSION}
        checkRet $? "${section}"
        docker image rm ${tag}:latest ${tag}:${VERSION}
    else
        echo 目标文件不存在 ${jar}
        exit 1
    fi
done
