FROM evarga/jenkins-slave:latest

MAINTAINER Ringtail <zhongwei.lzw@alibaba-inc.com>

USER root

ENV DEBIAN_FRONTEND noninteractive

# Adapted from: https://registry.hub.docker.com/u/jpetazzo/dind/dockerfile/
# Let's start with some basic stuff.
RUN apt-get update -qq && apt-get install -qqy \
apt-transport-https \
ca-certificates \
curl \
lxc \
git \
gcc \
make \
zlib1g \
zlib1g.dev \
openssl \
libssl-dev \
iptables && \
update-ca-certificates -f && \
rm -rf /var/lib/apt/lists/*


RUN wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.13-rc4/linux-headers-4.13.0-041300rc4_4.13.0-041300rc4.201708062231_all.deb \
    && wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.13-rc4/linux-headers-4.13.0-041300rc4-generic_4.13.0-041300rc4.201708062231_arm64.deb \
    && wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.13-rc4/linux-image-4.13.0-041300rc4-generic_4.13.0-041300rc4.201708062231_arm64.deb \
    && dpkg -i *.deb \
    && uname -sr


ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 17.03.1-ce

RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& chmod +x /usr/local/bin/docker


ADD slave.sh /usr/local/bin/slave.sh
ADD sshd_config /etc/ssh/sshd_config
RUN chmod +x /usr/local/bin/slave.sh

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["sh"]
