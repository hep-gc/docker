#!/bin/sh

docker build -t cs_container .
docker run -itd --privileged --name cs_container --hostname cs_host cs_container
