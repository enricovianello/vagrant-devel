#!/bin/bash
set -e

hostname=$(hostname)
# Where puppet modules will be installed
modules_dir="/etc/puppet/modules"

# Install puppet (assume it's not provided in the base image)
yum -y install puppet redhat-lsb-core

# Setup ssh root key
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# Avoid complains from mmcrcluster
cat > /root/.ssh/config << EOF
Host ${hostname}
UserKnownHostsFile /dev/null
StrictHostKeyChecking no
EOF

echo "Installing base puppet modules"

puppet module install --force maestrodev-wget
puppet module install --force gini-archive
puppet module install --force puppetlabs-stdlib
puppet module install --force maestrodev-maven
puppet module install --force puppetlabs-java

echo "Fetching puppet modules from: https://github.com/cnaf"

list=$(curl -s -S https://api.github.com/orgs/cnaf/repos|grep html_url|sed  's/[","]//g'|sed -rn  's/.+(https.+(puppet))/\1/p'|sed  's/https/git/g')

for url in $list; do 
  repo=$(echo $url|sed -rn  's/(^git.+(puppet))/\2/p' )
  git clone $url $modules_dir/$repo;
done
