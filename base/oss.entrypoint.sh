#!/bin/sh

export OSS_BUCKET=amzcs-uploads
export OSS_REGION=cn-hongkong
export OSS_TARGET=/data/amzcs/uploads

# amzcs-uploads
bucket=${OSS_BUCKET}
# cn-hongkong
region=${OSS_REGION}

target=${OSS_TARGET}

# 内网
oss_url=${bucket}.oss-${region}-internal.aliyuncs.com

mkdir -p ${target}
/usr/local/bin/ossfs ${bucket} ${target} -ourl=${oss_url}
