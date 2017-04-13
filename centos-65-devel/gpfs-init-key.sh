#!/bin/bash

# Setup ssh root key for GPFS self-communication
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# Avoid complains from mmcrcluster
cat > /root/.ssh/config << EOF
Host $(hostname -f)
UserKnownHostsFile /dev/null
StrictHostKeyChecking no
EOF
