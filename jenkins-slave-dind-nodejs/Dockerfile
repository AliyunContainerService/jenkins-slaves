FROM registry.aliyuncs.com/ringtail/jenkins-dind-slave:latest

RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get install -y nodejs

CMD ["/usr/sbin/sshd", "-D"]
