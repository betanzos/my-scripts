#!/bin/bash

# UDATE PACKAGES LIST
apt-get update


# INSTALL DOCKER
## Remove old docker packages
apt-get remove -y \
        docker \
        docker-engine \
        docker.io \
        docker-ce \
        docker-ce-cli \
        containerd \
        containerd.io \
        docker-compose \
        runc

## Install required packages for install Docker
apt-get install -y \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

## Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88

## Add the Docker stable repository
add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"

## Install the latest version of docker and docker-compose
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose
