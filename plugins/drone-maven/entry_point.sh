#!/bin/sh

VERSION=${DRONE_TAG}

if [[ -z "${VERSION}" ]]; then
    echo "找不到版本号"
    exit 1
fi

function checkRet() {
    z=$1
    if [[ "${z}" != "0" ]]; then
        echo "出错:${z}"
        exit ${z}
    fi
}

echo "设置版本号:${VERSION}"
mvn versions:set -DnewVersion=${VERSION} -B -q && mvn -N versions:update-child-modules -B -q && mvn versions:commit -B -q
checkRet $?

echo "编译项目"
mvn clean package -Dmaven.test.skip=true -Dmaven.javadoc.skip=true -B -q
checkRet $?
