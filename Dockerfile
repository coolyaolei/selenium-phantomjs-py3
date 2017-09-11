FROM debian:latest
MAINTAINER coolyaolei<coolyaolei@sina.com>

USER root

RUN pwd && \ 
# Change Mirror For China
sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
sed -i 's/deb http:\/\/security.debian.org/#deb http:\/\/security.debian.org/g' /etc/apt/sources.list && \
apt-get update && \
apt-get install -y python3 python3-selenium python3-pip wget

RUN pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple ipython

ENV PHANTOMJS phantomjs-2.1.1-linux-x86_64.tar.bz2
RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 && \
tar jxvfp $PHANTOMJS && \
mv phantomjs-2.1.1-linux-x86_64 /usr/local/phantomjs && \
ln -sf /usr/local/phantomjs/bin/phantomjs /bin/phantomjs \
rm -rf $PHANTOMJS

# Add Tini
ENV TINI_VERSION v0.16.1
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /sbin/tini
RUN chmod +x /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]
