#!/bin/bash

hostname=$(hostname)

mmcrcluster -N ${hostname}:quorum-manager -p ${hostname} -r /usr/bin/ssh
mmchlicense server --accept -N ${hostname}
mmstartup -a
sleep 5
mmgetstate -a

## Create GPFS disk definition
disk_def="/dev/sdb:${hostname}::dataAndMetadata:101:DMD_SND01:"
disk_def_file="/root/gpfs_disk_def.txt"

echo ${disk_def} > ${disk_def_file}
mmcrnsd -F ${disk_def_file}
mmcrfs gpfs -F ${disk_def_file} -A yes -Q yes -T /gpfs
mmmount /gpfs -a
mount
