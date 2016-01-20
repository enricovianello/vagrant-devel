#!/bin/bash

hostname=$(hostname)

mmcrcluster -N ${hostname}:quorum-manager -p ${hostname} -r /usr/bin/ssh
mmchlicense server --accept -N ${hostname}
mmstartup -a
sleep 5
mmgetstate -a
