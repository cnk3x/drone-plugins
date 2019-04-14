#!/bin/sh

export PATH=$PATH:usr/local/maven/bin

function checkRet() {
    code=$1
    title=$2
    if [[ ${code} == 0 ]]; then
        if [[ -z "${title}" ]]; then
            echo
        else
            echo "${title} 成功"
        fi
    else
        echo "${title} 失败,退出代码:${code}"
        exit ${code}
    fi
}

# VERSION=$(git describe --tags $(git rev-list --tags --max-count=1))
VERSION=$(cat VERSION)
if [[ -z "${VERSION}" ]]; then
    echo "读取版本号失败"
    exit 1
fi
echo VERSION:${VERSION}

DIST=$(cat DIST)
if [[ -z "${DIST}" ]]; then
    echo "获取目标JAR文件列表失败"
    exit 1
fi
echo DIST:${DIST}

if [[ -x "/usr/bin/docker" ]]; then
    echo "/usr/bin/docker can executable."
else
    echo "/usr/bin/docker is not executable."
    exit 1
fi

echo REGISTRY:${PLUGIN_REGISTRY}
echo REPO:${PLUGIN_GROUP}
echo USERNAME:${PLUGIN_USERNAME}
echo PASSWORD:${PLUGIN_PASSWORD}

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
        tag=${PLUGIN_REGISTRY}/${PLUGIN_GROUP}/java-${name}

        section="编译镜像 ${tag}:${VERSION} + latest"
        echo ${section}
        docker build \
            --tag ${tag}:${VERSION} \
            --tag ${tag}:latest \
            --build-arg JAR=${jar} . &&
            docker push ${tag}:latest &&
            docker push ${tag}:${VERSION}
        checkRet $? "${section}"
    else
        echo 目标文件不存在 ${jar}
        exit 1
    fi
done
