#!/bin/bash
set -e

yum clean all

# Install apache-maven
echo "Install apache-maven ..."
yum install -y wget
wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
yum -y install apache-maven

# Install other packages
echo "Install git redhat-lsb-core ntp vim-enhanced epel-release ..."
yum clean all
yum -y install git redhat-lsb-core ntp vim-enhanced epel-release
