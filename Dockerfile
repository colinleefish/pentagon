FROM rockylinux:9
LABEL MAINTAINER="colinleefish@gmail.com"

ARG KUBECTL_VERSION="v1.32.0"

# timezone
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    echo "tzdata tzdata/Areas select Asia" | debconf-set-selections && \
    echo "tzdata tzdata/Zones/Asia select Shanghai" | debconf-set-selections

RUN apt-get update && \
    apt-get install -y ca-certificates && \
    update-ca-certificates

### Install kubectl
RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl &&\
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 创建工作目录
RUN mkdir -p /root/workspace

# 设置环境变量
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

### Workspace
WORKDIR /root/workspace