#Shoal Docker Repository

This repository contains the Docker files for packaging the various components of the [Shoal](https://github.com/hep-gc/shoal)
web cache publishing system. For details of how shoal works checkout the [Shoal GitHib Page](https://github.com/hep-gc/shoal)


## Avalable Dockers

[**shoal-server**](shoal-server) maintains the list of running squids. It uses RabbitMQ to handle incoming AMQP messages from 
squid servers. It provides a REST interface for programatically retrieving a json formatted ordered list of squids.
It also provides a web interface for viewing the list.

[**shoal-agent**](shoal-agent) runs on squid servers and publishes the load and IP of the squid server to the shoal-server using 
a json formatted AMQP message at regular intervals. This agent is designed to be trivially installed in a
few seconds with python's pip tool.

[**shoal-client**](shoal-client) is a reference client that can be used to contact the REST interface of the shoal-server.

## DockerHub

All docker images are autobuilt on DockerHub from a CentOS 6 base. See the  [uvichep docker page](https://registry.hub.docker.com/repos/uvichep/).


