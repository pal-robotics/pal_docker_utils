#!/bin/bash

# Variables required for logging as a user with the same id as the user running this script
export LOCAL_USER_ID=`id -u $USER`
export LOCAL_GROUP_ID=`id -g $USER`
export LOCAL_GROUP_NAME=`id -gn $USER`
DOCKER_USER_ARGS="--env LOCAL_USER_ID --env LOCAL_GROUP_ID --env LOCAL_GROUP_NAME"

# Variables for forwarding ssh agent into docker container
SSH_AUTH_ARGS=""
if [ ! -z $SSH_AUTH_SOCK ]; then
    DOCKER_SSH_AUTH_ARGS="-v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK"
fi

# Settings required for having nvidia GPU acceleration inside the docker
DOCKER_GPU_ARGS="--env DISPLAY --env QT_X11_NO_MITSHM=1 --volume=/tmp/.X11-unix:/tmp/.X11-unix:rw"

which nvidia-docker > /dev/null
HAS_NVIDIA_DOCKER=$?
if [ $HAS_NVIDIA_DOCKER -eq 0 ]; then
  DOCKER_COMMAND=nvidia-docker
else
  echo "Running without nvidia-docker, if you have an NVidia card you may need it"\
  "to have GPU acceleration"
  DOCKER_COMMAND=docker
fi

xhost + 

$DOCKER_COMMAND run \
$DOCKER_USER_ARGS \
$DOCKER_GPU_ARGS \
$DOCKER_SSH_AUTH_ARGS \
--net host --privileged \
-v "$HOME/exchange:/home/user/exchange" \
-v /var/run/docker.sock:/var/run/docker.sock \
"$@"
