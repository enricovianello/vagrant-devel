#!/bin/bash
hostname=$(hostname)

disk_def="/dev/sdb:${hostname}::dataAndMetadata:101:DMD_SND01:"
disk_def_file="/root/gpfs_disk_def.txt"

if [ ! -e "${disk_def_file}" ]; then 
  echo ${disk_def} > ${disk_def_file}
  mmcrnsd -F ${disk_def_file}
  mmcrfs gpfs -F ${disk_def_file} -A yes -Q yes -T /storage
  mmmount /storage -a
  mmcrfileset gpfs test.vo
  mmlsfileset gpfs
  mmlinkfileset gpfs test.vo -J /storage/test.vo
  mount
else
  mmunmount gpfs
  mmdelfs gpfs
  mmcrfs gpfs -F ${disk_def_file} -A yes -Q yes -T /storage
  mmmount /storage -a
  mount
fi
