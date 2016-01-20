#!/bin/bash

yum install -y wget
yum install -y glibc-devel glibc-headers
wget http://vault.centos.org/7.0.1406/os/x86_64/Packages/kernel-devel-3.10.0-123.el7.x86_64.rpm
yum localinstall -y kernel-devel-3.10.0-123.el7.x86_64.rpm
