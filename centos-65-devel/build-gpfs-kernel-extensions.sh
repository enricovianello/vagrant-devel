#!/bin/bash
set -e

ROOT_RPM_PATH="/root/rpmbuild/RPMS/x86_64"
# Rebuild && install GPFS kernel extensions
cd /usr/lpp/mmfs/src
make LINUX_DISTRIBUTION=REDHAT_AS_LINUX Autoconfig
make World
make rpm
yum localinstall -y ${ROOT_RPM_PATH}/*.rpm
