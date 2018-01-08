FROM jenkins/slave:3.15-1
MAINTAINER ringtail <zhongwei.lzw@alibaba-inc.com>
LABEL Description="This is a base image, which allows connecting Jenkins agents via JNLP protocols" Vendor="Jenkins project" Version="3.15"

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

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 17.06.2-ce

RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& chmod +x /usr/local/bin/docker


RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

COPY jenkins-slave /usr/local/bin/jenkins-slave
ENTRYPOINT ["jenkins-slave"]
