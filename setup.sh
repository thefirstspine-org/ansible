#!/bin/bash
: '
This is the first setup script of ansible control node.
'

export DEBIAN_FRONTEND=noninteractive

# Setup docker reporsitory

apt-get update;
apt-get -y install \
	git \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common;
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -;
apt-key fingerprint 0EBFCD88;
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable";

# Install docker engine

apt-get update;
apt-get -y install docker-ce docker-ce-cli containerd.io;
