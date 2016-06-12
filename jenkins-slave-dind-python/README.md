## jenkins-slave-dind-python  

### Description
jenkins docker in docker python slave

### Usage
Use it with docker-compose    

```
python-slave:
  image: registry.aliyuncs.com/ringtail/jenkins-slave-python:latest
  privilege: true
  volumes:
      - /var/run/docker.sock:/var/run/docker.sock
```
