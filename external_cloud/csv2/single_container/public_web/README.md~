# External Cloud in a Single Container README

## Introduction

The files in this directory enable a user with access to a machine with a public IP address to create a docker CENTOS 7 container which runs both [HTCondor](https://research.cs.wisc.edu/htcondor/description.html) and cloudscheduler to launch virtual machines (VMs) and run HTCondor jobs on external clusters. 

## Prerequisites

To successfully launch VMs on external clusters from your machine, the following pre-requisites are needed:

* Root access on your machine (or sudo access, in which case all docker commands should be preceded by sudo)

* A running [docker installation](https://runnable.com/docker/install-docker-on-linux)

* The machine must have a public IP address in order to communicate with external clusters. You can determine your public IP address (if it exists) with the following command:

  $ curl ipinfo.io/ip

* The following ports should be open to external IPv4 traffic:

    * 9618/tcp and 9618/udp
    * 40000-50000/tcp

## Instructions

1. Edit the CENTRAL_MANAGER variable on line 134 of default.yaml so it reads: 

    CENTRAL_MANAGER=[your public IP address]

    where your public IP address can be obtained by typing: 

    ~~~~
    $ curl ipinfo.io/ip
    ~~~~

    Also, edit the NETWORK_INTERFACE variable on line 20 of condor_config.local so it reads:

    NETWORK_INTERFACE = [your public IP address]

2. Starting in the current (external_cloud/single_container) directory, build the docker container that will be running cloudscheduler and condor, and tag the container image as cloud_scheduler:

    ~~~~
    $ docker build -t cloud_scheduler .
    ~~~~
    
3. Run a docker container from the cloud_scheduler container image, forwarding the ports used by condor and cloudscheduler, and name the running container cs_container:

    ~~~~
    $ docker run -itd --privileged --name cs_container -p 9618:9618 -p 40000-40500:40000-40500 cloud_scheduler
    ~~~~

4. Start a bash shell in the running docker container:

    ~~~~
    $ docker exec -it cs_container /bin/bash
    ~~~~

5. The container should already be running condor and cloudscheduler, with the otter-container cloud enabled. The computecanada west cloud is also configured in the /etc/cloudscheduler/cloud_resources.conf file. More clouds can be added to the cloud_resources.conf file as needed. 

    To see the list of available clouds, type:

    ~~~~
    $ cloud_status 
    ~~~~


      Clouds can enabled or disabled using the cloud_admin command.

      To enable:

      ~~~~
      $ cloud_admin -e [cloud name]
      ~~~~

      To disable:

      ~~~~
      $ cloud_admin -d [cloud name]
      ~~~~

      For example, the otter-container cloud can be disabled using:

      ~~~~
      $ cloud_admin -d otter-container
      ~~~~
  
    If any of the files in /etc/cloudscheduler are updated, cloudscheduler needs to be restarted for the changes to take effect:

    ~~~~
    $ /etc/init.d/cloudscheduler quickrestart
    ~~~~

    After restarting cloudscheduler, clouds will need to be disabled or re-enabled using cloud_admin to get to the original settings. For example, to get back to the default setting of having only otter-container enabled:

    ~~~~
    $ cloud_admin -d cc-west-a
    $ cloud_admin -e otter-container
    ~~~~


6. The test job try.job in the /jobs directory can be run by switching to condor user, and using the condor_submit command:

    ~~~~
    $ su condor
    $ cd /jobs
    $ condor_submit try.job
    ~~~~

    To switch back to root user, type ctrl-D.

    To check the status of your job in the condor q type:

    ~~~~
    $ condor_q
    ~~~~

    For more information, use the better-analyze option

    ~~~~
    $ condor_q -better-analyze
    ~~~~

    Note that it may take ~5-10 minutes for the VM to boot and the job to start running.

    

