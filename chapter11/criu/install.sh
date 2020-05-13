#!/bin/sh

set -eux

# this is ubuntu 16.4

# install criu
apt-get update && apt-get install -y criu

apt-get install -y libltdl7

# install docker 17.3
wget https://download.docker.com/linux/ubuntu/dists/xenial/pool/stable/amd64/docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb
dpkg -i docker-ce_17.03.0~ce-0~ubuntu-xenial_amd64.deb

# docker checkpoint is an experimental feature, so you should enable docker experimental feature
echo "{\"experimental\":true}" >> /etc/docker/daemon.json
systemctl restart docker
