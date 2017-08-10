FROM registry.cn-beijing.aliyuncs.com/codepipeline/jenkins-slave-dind:0.2

MAINTAINER Ringtail <zhongwei.lzw@alibaba-inc.com>

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
    vim \
	&& rm -rf /var/lib/apt/lists/*

RUN mv /usr/bin/wget /usr/bin/wget_cli
RUN mv /usr/bin/git /usr/bin/git_cli

ADD ./git /usr/bin/git
ADD ./wget /usr/bin/wget

RUN chmod +x /usr/bin/git && \
    chmod +x /usr/bin/wget

RUN echo alias wget=/usr/bin/wget >> /etc/bashrc
RUN echo alias git=/usr/bin/git >> /etc/bashrc

CMD ["/usr/sbin/sshd", "-D"]
