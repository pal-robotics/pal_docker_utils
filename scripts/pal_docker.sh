#!/bin/bash

# Variables required for logging as a user with the same id as the user running this script
export LOCAL_USER_ID=`id -u $USER`
export LOCAL_GROUP_ID=`id -g $USER`
export LOCAL_GROUP_NAME=`id -gn $USER` 

# Settings required for having nvidia GPU acceleration inside the docker
export QT_X11_NO_MITSHM=1

# Settings required for ssh accesSettings required for ssh accesss
nvidia-docker run -it \
--env LOCAL_USER_ID --env LOCAL_GROUP_ID --env LOCAL_GROUP_NAME \
--env DISPLAY --env QT_X11_NO_MITSHM --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
-v $(dirname $SSH_AUTH_SOCK):$(dirname $SSH_AUTH_SOCK) -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
--net host --privileged \
-v "$HOME/exchange:/home/user/exchange" \
$*
