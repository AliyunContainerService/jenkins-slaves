FROM evarga/jenkins-slave:latest

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
rm -rf /var/lib/apt/lists/*

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.10.3
ENV DOCKER_SHA256 d0df512afa109006a450f41873634951e19ddabf8c7bd419caeb5a526032d86d

RUN curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION" -o /usr/local/bin/docker \
	&& echo "${DOCKER_SHA256}  /usr/local/bin/docker" | sha256sum -c - \
	&& chmod +x /usr/local/bin/docker



ADD slave.sh /usr/local/bin/slave.sh
RUN chmod +x /usr/local/bin/slave.sh
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers


COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["sh"]
