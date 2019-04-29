#!/usr/bin/env sh

USERNAME=${PLUGIN_USERNAME}
PASSWORD=${PLUGIN_PASSWORD}
REGISTRY=${PLUGIN_REGISTRY}
REPO_NS=${PLUGIN_NAMESPACE}
VERSION=${DRONE_TAG}
TARGET_FILE=${PLUGIN_TARGET_FILE}

if [[ -z "${VERSION}" ]]; then
    echo "找不到版本号"
    exit 1
fi

if [[ -z "${TARGET_FILE}" ]]; then
    TARGET_FILE=".drone.targets.json"
fi

function checkRet() {
    z=$1
    if [[ "${z}" != "0" ]]; then
        echo "出错:${z}"
        exit ${z}
    fi
}

if [[ -n "${USERNAME}" ]]; then
    if [[ -n "${PASSWORD}" ]]; then
        docker login --username=${USERNAME} --password=${PASSWORD} ${REGISTRY}
        checkRet $?
    fi
fi

function build() {
    config=$1
    NAME=$(echo ${config} | jq -c .name)
    IMAGE=$(echo ${config} | jq -c .image)
    SRC=$(echo ${config} | jq -c .src)
    TARGET=$(echo ${config} | jq -c .target)
    ENV=$(echo ${config} | jq -c .env)
    ENTRYPOINT=$(echo ${config} | jq -c .entry_point)
    CMD=$(echo ${config} | jq -c .cmd)

    NAME=${NAME//\"/}
    IMAGE=${IMAGE//\"/}
    SRC=${SRC//\"/}
    TARGET=${TARGET//\"/}

    SRC=${SRC//\{VERSION\}/${VERSION}}
    TARGET=${TARGET//\{VERSION\}/${VERSION}}
    ENTRYPOINT=${ENTRYPOINT//\{VERSION\}/${VERSION}}
    CMD=${CMD//\{VERSION\}/${VERSION}}
    ENV=${ENV//\{VERSION\}/${VERSION}}

    if [[ "${NAME}" == "null" ]]; then
        echo 名称[name]未设置
        exit 1
    fi

    if [[ "${IMAGE}" == "null" ]]; then
        echo 运行时镜像[image]未设置
        exit 1
    fi

    if [[ "${SRC}" == "null" ]]; then
        echo 源文件[src]未指定
        exit 2
    fi

    if [[ "${TARGET}" == "null" ]]; then
        TARGET="/app"
    fi

    if [[ "${ENTRYPOINT}" == "null" ]]; then
        # echo 启动入口[entry_point]未指定
        # exit 2
        ENTRYPOINT=""
    else
        ENTRYPOINT="ENTRYPOINT ${ENTRYPOINT}"
    fi

    if [[ "${CMD}" == "null" ]]; then
        CMD=""
    else
        CMD="CMD ${CMD}"
    fi

    if [[ "${ENV}" == "null" ]]; then
        ENV=""
    else
        es=${ENV}
        ENV="ENV"
        for e in $(echo ${es} | jq .[]); do
            ENV="${ENV} \\
    ${e//\"/}"
        done
    fi

    echo "${IMAGE}, ${SRC} -> ${TARGET}: ${ENTRYPOINT}"

    rm -f ${NAME}.Dockerfile
    cat >${NAME}.Dockerfile <<EOF
FROM ${IMAGE}
WORKDIR /app
${ENV}
COPY ${SRC} ${TARGET}
${ENTRYPOINT}
${CMD}
EOF
    cat ${NAME}.Dockerfile

    # if [[ -n "${REGISTRY}" ]]; then
    #     REGISTRY=${REGISTRY}/
    # fi

    # if [[ -n "${REPO_NS}" ]]; then
    #     REPO_NS=${REPO_NS}/
    # fi

    # REPO=${REGISTRY}${REPO_NS}${NAME}
    # echo build ${REPO}

    # if [[ -n "${VERSION}" ]]; then
    #     VersionTag="--tag ${REPO}:${VERSION}"
    # fi

    # docker build ${VersionTag} --tag ${REPO}:latest --file ./${NAME}.Dockerfile .
    # checkRet $?
    # rm ${NAME}.Dockerfile

    # docker images | grep ${REPO} | grep -v latest | grep -v ${VERSION} | awk '{print $1":"$2}' | xargs -I {} docker rmi {}
    # docker images | grep ${REPO} | grep none | awk '{print $3}' | xargs -I {} docker rmi {}

    # docker push ${REPO}
    # checkRet $?
}

targets=$(cat ${TARGET_FILE})
checkRet $?

if [[ -z "${targets}" ]]; then
    echo "${TARGET_FILE}是个空文件"
    exit 1
fi

if [[ "${targets:0:1}" == '{' ]]; then
    targets="[${targets}]"
fi

configs=$(echo ${targets} | jq -c '.[]')
checkRet $?

for config in ${configs}; do
    build ${config}
    checkRet $?
done
