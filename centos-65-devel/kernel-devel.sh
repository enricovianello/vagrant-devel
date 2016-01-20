#!/bin/bash

yum install -y wget
yum install -y glibc-devel glibc-headers
#wget http://vault.centos.org/6.5/os/x86_64/Packages/kernel-devel-2.6.32-431.el6.x86_64.rpm
#yum localinstall -y kernel-devel-2.6.32-431.el6.x86_64.rpm

# Users and groups
user="vianello"
userid=1001
group="vianello"
groupid=1001

echo "Add $user user ..."
useradd -u $userid $user || echo "User $user already exists."
echo "Add $group group ..."
groupadd $group -g $groupid || echo "Group $group already exists."
echo "Add $group group to $user groups ..."
usermod -G $group $user
echo "Print $user user info ..."
id $user