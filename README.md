This repo contains scripts and documentation for making using docker simpler.

# Requirements
## nvidia-docker
**Only if your computer has an NVIDIA GPU**

Some of these scripts use https://github.com/NVIDIA/nvidia-docker to be able 
to have graphic hardware acceleration.

We use version [1.0 of nvidia-docker](https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-1.0))

# Utilities
## scripts/pal\_docker.sh

This script launches a docker container with the following features:
- Expose xhost, this can compromise the access control to your X server. 
Read [this](http://wiki.ros.org/docker/Tutorials/GUI#The_simple_way)
- nvidia docker for hardware acceleration if it is installed
- It captures the user id and group id, and runs the docker as that user 
([more info](https://denibertovic.com/posts/handling-permissions-with-docker-volumes/)).
- If the env variable SSH_AUTH_SOCK is available, it uses it to forward 
the ssh agent into the container
- Uses the host's network (https://docs.docker.com/engine/reference/run/#network-settings)
- Uses the --privileged flag (https://docs.docker.com/engine/reference/run/#security-configuration)
- Mounts a volume (shared directory) from the users $HOME/exchange inside the dockers'
/home/user/exchange for sharing files

### Usage
Takes the same arguments as `docker run`, which are appended to the 
arguments provided by the script.

Examples:

`pal_docker.sh my_docker_image`

`pal_docker.sh -it my_docker_image bash`

