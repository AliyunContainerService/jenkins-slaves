#!/bin/bash

if [ $# -lt 1 ]; then
    echo "You should set the workspace path"
    exit 1
fi

workspace="$1"
testScriptsPath="$workspace/test.sh"
buildScriptsPath="$workspace/build.sh"
dockerfilePath="$workspace/Dockerfile"

function checkResult(){
  if [ ! "$1" == "0"  ];then
    exit 1;
  fi
}

if [ -a "$buildScriptsPath" ]; then
  bash -c "$buildScriptsPath"
  checkResult $?
else
  echo "build.sh not found,skip build step"
fi

if [ -a "$testScriptsPath" ]; then
  bash -c "$testScriptsPath"
  checkResult $?
else
  echo "test.sh not found,skip test step"
fi

if [ -a "$dockerfilePath" ]; then
  if [ "x$image_repo" == "x" ];then
    echo "image_repo not set and won't publish image"
    exit 1
  fi
  sudo docker build -t "$image_repo" .
  sudo docker push "$image_repo"
else
  echo "Dockerfile not found,skip image build and publish step"
fi

if [ ! "x$trigger_url" == "x" ];then
    curl "$trigger_url"
else
  echo "trigger_url not set,skip trigger step"
fi
