#!/bin/sh

docker build -t condor_container .
docker run -itd --privileged -p 9618:9618 -p 40000-40500:40000-40500 condor_container

while true; do sleep 1; done 
