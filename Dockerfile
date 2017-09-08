FROM debian:latest
MAINTAINER coolyaolei<coolyaolei@sina.com>

USER root

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
sed -i 's/deb http:\/\/security.debian.org/#deb http:\/\/security.debian.org/g' /etc/apt/sources.list && \
apt-get update && \
apt-get -y install python3 python3-selenium phantomjs


# Add Tini
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]
