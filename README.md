IBM Bluemix Containers box
==========================

Simple Vagrantfile to set up IBM Bluemix and Bluemix Containers
connectivity in an Ubuntu VirtualBox instance.

Define ibm_email and ibm_pass that conrrespond to your login
credentials as environment variables and do "vagrant up".

This assumes eu-gb hosting zone. For other regions, change the domain
names in install-bluemix-cli.sh script.

After that, do "vagrant ssh" and use "cf ic info" etc to do
your tasks against the cloudfoundry cloud by Bluemix, or
"docker" to work with images locally.