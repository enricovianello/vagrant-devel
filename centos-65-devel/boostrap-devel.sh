#!/bin/bash
set -e

# Install certificate
mkdir -p /etc/grid-security
cp /vagrant/certificate/centos6_devel_cnaf_infn_it.cert.pem /etc/grid-security/hostcert.pem
cp /vagrant/certificate/centos6_devel_cnaf_infn_it.cert.pem /etc/grid-security/hostkey.pem
chmod 644 /etc/grid-security/hostcert.pem
chmod 400 /etc/grid-security/hostkey.pem

echo "hostname -f => $(hostname -f)"
# Where puppet modules will be installed
modules_dir="/etc/puppet/modules"

# Install puppet (assume it's not provided in the base image)
yum -y install puppet redhat-lsb-core ntp

# Setup ssh root key for GPFS self-communication
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# Avoid complains from mmcrcluster
cat > /root/.ssh/config << EOF
Host $(hostname -f)
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
