# External Cloud README

## Introduction

The files in this directory enable a user with access to a machine with a public IP address to create a docker CENTOS 7 container which runs clouscheduler to launch virtual machines (VMs) and run [HTCondor](https://research.cs.wisc.edu/htcondor/description.html) jobs on external clusters. 

## Prerequisites

To successfully launch VMs on external clusters from your machine, the following pre-requisites are needed:

* A running [docker installation](https://runnable.com/docker/install-docker-on-linux)

* The machine must have a public IP address in order to communicate with external clusters. You can determine your public IP address (if it exists) with the following command:

  $ curl ipinfo.io/ip

* The following ports should be open to external IPv4 traffic:

    * 9618/tcp and 9618/udp
    * 40000-50000/tcp

## Instructions

1. cd into the 
