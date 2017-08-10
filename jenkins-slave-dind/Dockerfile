FROM ubuntu:16.04

MAINTAINER Ringtail <zhongwei.lzw@alibaba-inc.com>

USER root

ADD sources.list /etc/apt/sources.list

# Add locales after locale-gen as needed
# Upgrade packages on image
# Preparations for sshd
RUN apt-get -q update && \
		apt-get dist-upgrade -y && \
    DEBIAN_FRONTEND="noninteractive" apt-get -q upgrade -y -o Dpkg::Options::="--force-confnew" --no-install-recommends &&\
    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends openssh-server &&\
		DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends software-properties-common &&\
		    add-apt-repository -y ppa:openjdk-r/ppa &&\
		    apt-get -q update &&\
		    DEBIAN_FRONTEND="noninteractive" apt-get -q install -y -o Dpkg::Options::="--force-confnew" --no-install-recommends openjdk-8-jre-headless &&\
		    apt-get -q clean -y && \
				apt-get install -qqy apt-transport-https \
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
    apt-get -q autoremove &&\
    apt-get -q clean -y && rm -rf /var/lib/apt/lists/* && rm -f /var/cache/apt/*.bin &&\
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd &&\
    mkdir -p /var/run/sshd

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set user jenkins to the image
RUN useradd -m -d /home/jenkins -s /bin/sh jenkins
ENV DEBIAN_FRONTEND noninteractive

ENV DOCKER_CHANNEL stable
ENV DOCKER_VERSION 17.03.1-ce

RUN curl -fL -o docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" \
	&& tar -xzvf docker.tgz \
	&& mv docker/* /usr/local/bin/ \
	&& rmdir docker \
	&& rm docker.tgz \
	&& chmod +x /usr/local/bin/docker

ADD sshd_config /etc/ssh/sshd_config

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["sh"]
