#!/bin/bash

# Replace line in defaults.yaml.j2 where the public IP needs to be specified                                                                                                        
public_ip=$(curl -s http://whatismyip.akamai.com/) 
grep -q "^        CONDOR_HOST=" /opt/cloudscheduler/default.yaml.j2 && sed "s/^        CONDOR_HOST=.*/        CONDOR_HOST=$public_ip/" -i /opt/cloudscheduler/default.yaml.j2 || sed "$ a\        CONDOR_HOST=$public_ip" -i /opt/cloudscheduler/default.yaml.j2

# Remove the existing defaults.yaml.j2 file
cloudscheduler group metadata-delete -mn default.yaml.j2 -Y

# Upload the updated defaults.yaml.j2 file
cloudscheduler group metadata-load -f /opt/cloudscheduler/default.yaml.j2 -mn default.yaml.j2
