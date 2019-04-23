#!/bin/sh

BASE_DIR=${BASE_DIR}
echo "BASE_DIR:${BASE_DIR}"
if [[ -z "${BASE_DIR}" ]]; then
    BASE_DIR=/data/amzcs/www
    echo "BASE_DIR:${BASE_DIR}"
fi

if [[ -z "${PLUGIN_HOST}" ]]; then
    echo "需要设置 host"
    exit 1
fi

if [[ -z "${PLUGIN_NAME}" ]]; then
    echo "需要设置 name: 存储的目标路径"
    exit 1
fi

cat >>identity <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
${PLUGIN_IDENTITY}
-----END OPENSSH PRIVATE KEY-----
EOF
chmod 0600 identity

DIR=${BASE_DIR}/${PLUGIN_NAME}

if [[ -d "dist" ]]; then
    ssh -i identity -o StrictHostKeyChecking=no ${PLUGIN_HOST} "mkdir -p ${DIR} && cd ${DIR} && tar -czf ../${PLUGIN_NAME}-$(date +%Y-%m-%dT%H-%M-%S%z).tar.gz . && rm -rf ${DIR}" &&
        scp -i identity -o StrictHostKeyChecking=no -r dist ${PLUGIN_HOST}:${DIR}
    code=$?

    if [[ "${code}" == "0" ]]; then
        echo "操作完成"
    else
        echo "操作失败:${code}"
        exit 1
    fi
else
    echo "dist目录不存在，上一步编译未成功"
    exit 1
fi
