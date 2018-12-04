#!/bin/bash

# Remove the existing defaults.yaml.j2 file
cloudscheduler group metadata-delete -mn default.yaml.j2 -Y

# Upload the updated defaults.yaml.j2 file
cloudscheduler group metadata-load -f /opt/cloudscheduler/default.yaml.j2 -mn default.yaml.j2
