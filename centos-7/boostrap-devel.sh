#!/bin/bash
set -e

# Install certificate
#mkdir -p /etc/grid-security
#cp /vagrant/certificate/centos6_devel_cnaf_infn_it.cert.pem /etc/grid-security/hostcert.pem
#cp /vagrant/certificate/centos6_devel_cnaf_infn_it.key.pem /etc/grid-security/hostkey.pem
#chmod 644 /etc/grid-security/hostcert.pem
#chmod 400 /etc/grid-security/hostkey.pem

echo "hostname -f => $(hostname -f)"
# Where puppet modules will be installed
modules_dir="/etc/puppet/modules"

# Install puppet (assume it's not provided in the base image)
yum -y install puppet redhat-lsb-core ntp vim-enhanced

# Setup ssh root key for GPFS self-communication
rm -f /root/.ssh/id_rsa*
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

if [ ! -e "ci-puppet-modules" ]; then
  git clone https://github.com/cnaf/ci-puppet-modules.git
else
  pushd ci-puppet-modules
  git pull
  popd
fi
