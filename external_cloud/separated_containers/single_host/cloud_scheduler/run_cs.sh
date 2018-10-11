#!/bin/sh

docker build -t cs_container .
docker run -itd --privileged --name cs_container --hostname cs_host --ip 172.17.0.3 cs_container
