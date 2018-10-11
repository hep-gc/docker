#!/bin/sh

docker build -t condor_container .
docker run -itd --privileged --name condor_container --hostname htcondor_host -p 9618:9618 -p 40000-40500:40000-40500 condor_container
