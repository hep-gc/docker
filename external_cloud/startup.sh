#!/bin/sh

# start libvirtd
/usr/bin/systemctl start libvirtd

# start condor
/usr/bin/systemctl start condor

# start cloudscheduler, disable container-cloud, and enable cc-west cloud
/etc/init.d/cloud_scheduler start
cloud_admin -d container-cloud
cloud_admin -e cc-west-a

while true; do sleep 1; done 
