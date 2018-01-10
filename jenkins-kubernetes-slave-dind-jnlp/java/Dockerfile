FROM registry.cn-beijing.aliyuncs.com/acs-sample/jenkins-kubernetes-slave-dind:1.0

#maven
ENV MAVEN_VERSION 3.3.9

ADD code.key code.key
RUN cat code.key >> /etc/ssl/certs/ca-certificates.crt
RUN rm code.key

RUN mkdir -p /usr/share/maven \
  && curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

#gradle
ENV GRADLE_VERSION 2.6

RUN mkdir -p /usr/share/gradle-${GRADLE_VERSION} \
  && curl -sLO https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-all.zip \
  && unzip gradle-${GRADLE_VERSION}-all.zip -d /usr/share \
  && ln -s /usr/share/gradle-${GRADLE_VERSION}/bin/gradle /usr/bin/gradle \
  && rm gradle-${GRADLE_VERSION}-all.zip

ENV GRADLE_HOME /usr/share/gradle-${GRADLE_VERSION}
ENV PATH $PATH:$GRADLE_HOME/bin

#git ignore ssl
RUN git config --global http.sslVerify "false"
USER jenkins
RUN git config --global http.sslVerify "false"
USER root

#scala
ENV SCALA_VERSION 2.12.3
ENV SBT_VERSION 1.0.2

## Piping curl directly in tar
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc

# Install sbt
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

RUN chmod -R 777 /home/jenkins
