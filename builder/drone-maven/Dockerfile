FROM centos:7

# 安装 docker 和 jdk 基础环境
RUN yum install libtool-ltdl git java-1.8.0-openjdk-devel which -y && yum clean all

# 安装 maven
RUN curl -SL http://mirrors.tuna.tsinghua.edu.cn/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz \
    | tar -zxC /usr/local/ && \
    mv /usr/local/apache-maven-3.6.1 /usr/local/maven && \
    echo "PATH=$PATH:/usr/local/maven/bin" > /etc/profile.d/maven.sh

COPY ./java.Dockerfile ./entry_point.sh /
RUN chmod +x /entry_point.sh

CMD [ "/entry_point.sh" ]
# ENTRYPOINT [ "/entry_point.sh" ]
