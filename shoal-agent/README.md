# docker-shoal-agent
Configuration: Edit the configuration file /etc/shoal/shoal_agent.conf

Commands: service shoal-agent [start | stop | reload | status | force restart]

Overview:

Shoal is a scalable squid cache publishing and advertising tool developed for highly dynamic environments.

There are the three components to shoal.

Server: shoal-server maintains the list of running squids. Through RabbitMQ it handles incoming AMQP messages from squid servers. An ordered list of squids can be retrieved in a json format through the REST interface. A human formatted web interface is also provided.

Agent: shoal-agent runs on squid servers publishing their load and IP to the shoal-server through json formatted AMQP messages at regular intervals.

Client: shoal-client is a reference client that can be used to contact the shoal-server through the REST interface.

Shoal was developed, and is maintained, by the University of Victoria High Energy Physics Research Computation Group.

It lives on GitHub: github.com/hep-gc/shoal
Comments

No comments available, be the first to comment.
