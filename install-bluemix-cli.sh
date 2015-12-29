#!/bin/bash

# Instructions from:

# https://onehundred15.wordpress.com/2015/11/20/ibm-bluemix-containers/

set -ex

ibm_email=$1
ibm_pass=$2

if [[ -z "$ibm_email" ]] || [[ -z "$ibm_pass" ]]
then
  echo ibm_email and ibm_pass need to be defined, use: >&2
  echo ibm_email=your@email ibm_pass=yourpass vagrant up >&2
  exit 1
fi

cd ~
curl -s -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
sudo mv ~/cf /usr/local/bin
cf --version

cf install-plugin -f https://static-ice.ng.bluemix.net/ibm-containers-linux_x64

# ng for us/southwest, this is is eu-gb
cf login -a https://api.eu-gb.bluemix.net -u $ibm_email -p $ibm_pass
cf ic login -R registry.eu-gb.bluemix.net || true
cf ic init
