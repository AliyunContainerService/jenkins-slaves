## jenkins-slave-dind-nodejs  

### Description
jenkins docker in docker nodes slave

### Usage
Use it with docker-compose    

```
nodejs-slave:
  image: registry.aliyuncs.com/qinyujia-test/jenkins-slave-nodejs:latest
  privilege: true
  volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
