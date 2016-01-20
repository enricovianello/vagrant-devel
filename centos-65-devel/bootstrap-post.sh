#!/bin/bash

STORM_BUILD_DIR = ENV['HOME'] + '/git/storm'
# STORM_WEBDAV_BUILD_DIR = ENV['HOME'] + '/git/storm-webdav'
# STORM_TESTSUITE_DIR = ENV['HOME'] + '/git/storm-testsuite'
STORM_LOAD_TESTSUITE_DIR = ENV['HOME'] + '/git/grinder-load-testsuite'
# STORM_QUOTACTL_DIR = ENV['HOME'] + '/git/storm-quotactl-java'
# VOMS_ADMIN_BUILD_DIR = ENV['HOME'] + '/git/voms-admin-server'
# ARGUS_BUILD_DIR = ENV['HOME'] + '/git/argus-pap'
# JREBEL_BASE_DIR = ENV['HOME'] + '/.jrebel'

# Set permissions
mount -t vboxsf -o uid=`id -u vianello`,gid=`id -g vianello`,dmode=755,fmode=644 $STORM_BUILD_DIR /opt/storm
mount -t vboxsf -o uid=`id -u vianello`,gid=`id -g vianello`,dmode=755,fmode=644 $STORM_LOAD_TESTSUITE_DIR /home/vianello/grinder-load-testsuite