This repo contains scripts and documentation for making using docker simpler.

# Requirements
## NVIDIA Docker
**Only if your computer has an NVIDIA GPU**

If you have an NVIDIA GPU, you can install NVIDIA Docker to enable graphic 
hardware acceleration inside PAL containers.

We use version 2.0 of NVIDIA Docker, and to to install it, just follow the 
[instructions](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker).

**Note**

To validate the installation, at the end of the instructions page it is suggested 
to run a docker with nvidia CUDA. However this needs about 1GB of download and 
unless you are planning to use CUDA in a docker that is quite unnecessary. 

Instead of doing that, you can run pal_docker.sh with any of our images and once 
inside, execute `glxinfo | grep render` and you should have a line that says: 
**direct rendering: Yes** . If this is the case, the graphic hardware acceleration is working.

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

`pal_docker.sh -it my_docker_image bash` (*ferrum*)

