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

echo "检查JAR文件列表"
DIST=$(cat .drone.targets)
if [[ -z "${DIST}" ]]; then
    echo "获取目标文件列表失败，请检查 .drone.targets 文件"
    exit 1
else
    echo ${DIST} | xargs -I {} dirname {}
fi

echo "检查 docker"
if [[ -S "/var/run/docker.sock" ]]; then
    echo "docker 已启动."
else
    echo "docker 未运行."
    exit 1
fi

section="登录镜像仓库"
echo ${section}
docker login --username=${PLUGIN_USERNAME} --password=${PLUGIN_PASSWORD} ${PLUGIN_REGISTRY}
checkRet $? "${section}"

function BuildAndPush() {
    tag=$1
    dist=$2
    ext=$3

    section="编译镜像 ${tag}:latest"
    echo ${section}
    docker build --tag ${tag}:latest --build-arg dist=${dist} -f ${ext}.Dockerfile .
    checkRet $? "${section}"

    section="发布镜像 ${tag}:latest"
    echo ${section}
    docker push ${tag}:latest
    checkRet $? "${section}"
}

function BuildJavaImage() {
    repo_name=$1
    base_name=$2
    dist=${base_name}-${VERSION}.jar

    if [[ -f "${dist}" ]]; then
        cp /java.Dockerfile java.Dockerfile
        tag=${PLUGIN_REGISTRY}/${PLUGIN_NAMESPACE}/${repo_name}
        BuildAndPush ${tag} ${dist} java
    else
        echo "找不到目标文件"
        exit 1
    fi
}

function BuildNativeImage() {
    repo_name=$1
    base_name=$2
    dist=${base_name}-${VERSION}

    if [[ -f "${dist}" ]]; then
        cp /native.Dockerfile native.Dockerfile
        tag=${PLUGIN_REGISTRY}/${PLUGIN_NAMESPACE}/${repo_name}
        BuildAndPush ${tag} ${dist} native
    fi
}

function BuildDotnetImage() {
    repo_name=$1
    dll=$(basename $2)
    dir=$(dirname $2)
    dist=${dir}-${VERSION}

    if [[ -d "${dist}" ]]; then
        cp /dotnet.Dockerfile dotnet.Dockerfile
        tag=${PLUGIN_REGISTRY}/${PLUGIN_NAMESPACE}/${repo_name}
        BuildAndPush ${tag} ${dist} dotnet

        section="编译镜像 ${tag}:latest"
        echo ${section}
        docker build --tag ${tag}:latest --build-arg dist=${dist} --build-arg dll=${dll} -f dotnet.Dockerfile .
        checkRet $? "${section}"

        section="发布镜像 ${tag}:latest"
        echo ${section}
        docker push ${tag}:latest
        checkRet $? "${section}"
    else
        echo "找不到目标文件"
        exit 1
    fi
}

for app in ${DIST}; do
    ext=$(basename ${app})
    app=$(dirname ${app})
    repo_name=$(basename ${app})
    app=$(dirname ${app})

    case ${ext} in
    java)
        BuildJavaImage ${repo_name} ${app}
        ;;
    native)
        BuildNativeImage ${repo_name} ${app}
        ;;
    dotnet)
        BuildDotnetImage ${repo_name} ${app}
        ;;
    *)
        echo 无法识别${ext}
        exit 1
        ;;
    esac

done
