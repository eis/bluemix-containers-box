# Instructions from:

# https://docs.docker.com/engine/installation/ubuntulinux/

# Run as elevated user

set -ex

apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list

apt-get update

apt-get -y install linux-image-extra-$(uname -r)

apt-get -y install docker-engine

sudo usermod -aG docker vagrant

docker run hello-world