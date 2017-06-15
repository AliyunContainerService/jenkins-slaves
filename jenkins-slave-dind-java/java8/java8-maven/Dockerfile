FROM registry.aliyuncs.com/acs-sample/jenkins-slave-dind-java:0.1

ENV MAVEN_VERSION 3.3.9


ADD code.key code.key
RUN cat code.key >> /etc/ssl/certs/ca-certificates.crt
RUN rm code.key

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

CMD ["/usr/sbin/sshd", "-D"]
