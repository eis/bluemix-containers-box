IBM Bluemix Containers box
==========================

Simple Vagrantfile to set up IBM Bluemix and Bluemix Containers
connectivity in an Ubuntu VirtualBox instance. Also contains example
Vagrantfile and Node.js app so that containers can be tested.

Note that this installs old version (1.8.1) of Docker, since Bluemix
[doesn't support current versions]
(https://www.ng.bluemix.net/docs/containers/container_cli_ov.html).

Prerequisite: you have to have registered to Bluemix, so you have IBM
id email and password available. Also assumes Vagrant, Virtualbox installed.

File descriptions
-----------------

Repository metadata
 - .gitignore: git file repository metadata, which files we do not store
 - README.md: this file
 - LICENSE: your rights as a user of this code

Local environment scripts
 - Vagrantfile: creates your local Ubuntu instance
 - install-docker.sh: helper script for Vagrant to install Docker
 - install-bluemix-cli.sh: helper script for Vagrant to install Bluemix

Example Node.js application
 - package.json: tells what our app dependencies are
 - server.js: actual application

Application container
 - Dockerfile: contains the file we use to set up runtime container for our app, both remotely and locally

Using to communicate with Bluemix
---------------------------------

Just define ibm_email and ibm_pass that correspond to your login
credentials as environment variables and do `vagrant up`.

This assumes eu-gb hosting zone. For other regions, change the domain
names in install-bluemix-cli.sh script.

After that, you can use "vagrant ssh" and cf ic info" etc to do
your tasks against the cloudfoundry cloud by Bluemix, or
"docker" to work with images locally.

Using the example Dockerfile
--------------------
Example Dockerfile is using instructions from
[here](https://nodejs.org/en/docs/guides/nodejs-docker-webapp/).

It can be taken into local use with

```
$ vagrant ssh
$ cd /vagrant

# Build it
$ docker build -t $yourusername/node-web-app .

# should show $yourusername/node-web-app
$ docker images

# let's run it!
$ docker run -p 49160:8080 -d $yourusername/node-web-app

# shows the id, port
$ docker ps

$ curl -i localhost:49160

HTTP/1.1 200 OK
X-Powered-By: Express
Content-Type: text/html; charset=utf-8
Content-Length: 12
ETag: W/"c-8O9wgeFTmsAO9bdhtPsBsw"
Date: Tue, 29 Dec 2015 14:00:06 GMT
Connection: keep-alive

Hello world
```

Using example Node.js Dockerfile on Bluemix
-------------------------------------------

```
$ vagrant ssh
$ cd /vagrant
$ cf ic login

# view namespace, registry
$ cf ic info

# view docker image tag
$ docker ps -a

# associate them
$ docker tag $yourusername/node-web-app registry.eu-gb.bluemix.net/$yournamespace/$newimagename

# and push
$ docker push registry.eu-gb.bluemix.net/$yournamespace/$newimagename

# and run
$ cf ic run --name $NEWCONTAINERNAME -p 8080:8080 -p 443:443 -d -t registry.eu-gb.bluemix.net/$yournamespace/$newimagename

# See ip
$ cf ip list -a

# Use ip:8080 from your browser to see your app
```
