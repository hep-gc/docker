# docker-shoal-server
Configuration: Edit the configuration file /etc/shoal/shoal_server.conf

The RabbitMQ server can be installed by running yum install rabbitmq Alternately there is a Docker Container with RabbitMQ already installed uvichep/shoal-server-rabbitmq

Running Container: expose port 80 - HTTP, 5671 & 5672 - AMQP with and without TLS

Overview:

Shoal is a scalable squid cache publishing and advertising tool developed for highly dynamic environments.

There are the three components to shoal.

Server: shoal-server maintains the list of running squids. Through RabbitMQ it handles incoming AMQP messages from squid servers. An ordered list of squids can be retrieved in a json format through the REST interface. A human formatted web interface is also provided.

Agent: shoal-agent runs on squid servers publishing their load and IP to the shoal-server through json formatted AMQP messages at regular intervals.

Client: shoal-client is a reference client that can be used to contact the shoal-server through the REST interface.

Shoal was developed and is maintained by the University of Victoria High Energy Physics Research Computation Group.

It lives on GitHub: github.com/hep-gc/shoal
