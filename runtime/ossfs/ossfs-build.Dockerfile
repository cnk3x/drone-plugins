FROM shuxs/alpine as builder

ENV GIT_COMMIT 346a355
RUN apk --update add fuse alpine-sdk automake autoconf libxml2-dev fuse-dev curl-dev \
    && wget -qO- https://github.com/aliyun/ossfs/archive/master.tar.gz |tar xz \
    && cd ossfs-master \
    && ./autogen.sh \
    && ./configure --prefix=/usr \
    && make \
    && make install \
    && rm -rf /var/cache/apk/* 
