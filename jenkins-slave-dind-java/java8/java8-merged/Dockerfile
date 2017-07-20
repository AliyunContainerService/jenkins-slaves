FROM registry.cn-beijing.aliyuncs.com/codepipeline/jenkins-slave-dind-java:0.1

#mirrors
RUN cat sources.list >> /etc/apt/sources.list

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

RUN chmod -R 777 /tmp 
  
ENV GRADLE_HOME /usr/share/gradle-${GRADLE_VERSION}
ENV PATH $PATH:$GRADLE_HOME/bin

RUN chmod -R 777 /home/jenkins	

CMD ["/usr/sbin/sshd", "-D"]
