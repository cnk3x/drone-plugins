# docker build -t shuxs/ossfs:latest . && docker push shuxs/ossfs:latest
FROM shuxs/alpine:latest

RUN apk --update add fuse curl libxml2 openssl libstdc++ libgcc && rm -rf /var/cache/apk/* 
COPY ossfs-346a355 /usr/bin/ossfs
COPY ossfs-fs /usr/bin/fs
RUN chmod +x /usr/bin/ossfs && chmod +x /usr/bin/fs

ENTRYPOINT [ "fs" ]