#!/bin/sh

source /etc/profile

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

section="检查 maven"
echo ${section}
mvn -v
checkRet $? "${section}"

echo "检查版本号"
VERSION=$(cat VERSION)
if [[ -z "${VERSION}" ]]; then
    echo "读取版本号失败."
    exit 1
else
    echo VERSION:${VERSION}
fi

echo "检查JAR文件列表"
DIST=$(cat DIST)
if [[ -z "${DIST}" ]]; then
    DIST="target/${PLUGIN_NAME}/${PLUGIN_NAME}"
    echo "获取目标JAR文件列表失败, 设置为默认：$(dirname ${DIST})"
else
    echo ${DIST} | xargs -I {} dirname {}
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

section="设置版本号:${VERSION}"
echo ${section}
mvn versions:set -DnewVersion=${VERSION} -B && mvn -N versions:update-child-modules -B && mvn versions:commit -B
checkRet $? "${section}"

section="编译项目"
echo ${section}
mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true -B
checkRet $? "${section}"

section="登录镜像仓库"
echo ${section}
docker login --username=${PLUGIN_USERNAME} --password=${PLUGIN_PASSWORD} ${PLUGIN_REGISTRY}
checkRet $? "${section}"

cp /java.Dockerfile Dockerfile

for app in ${DIST}; do
    name=$(basename ${app})
    jar=$(dirname ${app})-${VERSION}.jar
    if [[ -f ${jar} ]]; then
        tag=${PLUGIN_REGISTRY}/${PLUGIN_NAMESPACE}/java-${name}

        section="编译镜像 ${tag}:${VERSION} + latest"
        echo ${section}
        docker build --tag ${tag}:${VERSION} --build-arg JAR=${jar} .
        checkRet $? "${section}"

        section="发布镜像 ${tag}:${VERSION}"
        echo ${section}
        docker push ${tag}:${VERSION}
        checkRet $? "${section}"

        section="清理"
        echo ${section}
        docker image rm ${tag}:latest ${tag}:${VERSION}
        checkRet $? "${section}"
    else
        echo 目标文件不存在 ${jar}
        exit 1
    fi
done
