#!/bin/bash

# install epel release
yum install -y epel-release

# Added missing package to avoid fetch-crl packaging bug
yum install -y perl-libwww-perl.noarch

# install utilities
yum install -y fetch-crl nc

# run fetch-crl
fetch-crl

# check if errors occurred after fetch-crl execution
if [ $? != 0 ]; then
  exit 1
fi

pip install --upgrade robotframework-httplibrary

# install clients
yum install -y voms-clients3 myproxy

# setup for the tester user
adduser -d /home/tester tester
mkdir /home/tester/.globus
chown -R tester.tester /home/tester/.globus

echo 'export X509_USER_PROXY="/tmp/x509up_u$(id -u)"'>/etc/profile.d/x509_user_proxy.sh
