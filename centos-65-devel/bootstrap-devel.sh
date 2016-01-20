#!/bin/bash
set -e

# Install certificate
mkdir -p /etc/grid-security
cp -f /vagrant/certificate/centos6_devel_cnaf_infn_it.cert.pem /etc/grid-security/hostcert.pem
cp -f /vagrant/certificate/centos6_devel_cnaf_infn_it.key.pem /etc/grid-security/hostkey.pem
chmod 644 /etc/grid-security/hostcert.pem
chmod 400 /etc/grid-security/hostkey.pem

echo "hostname -f => $(hostname -f)"

# Where puppet modules will be installed
modules_dir="/etc/puppet/modules"

# Install puppet (assume it's not provided in the base image)
echo "yum clean all"
yum clean all
echo "yum -y install puppet redhat-lsb-core ntp vim-enhanced"
yum -y install puppet redhat-lsb-core ntp vim-enhanced apache-maven

# Setup ssh root key for GPFS self-communication
rm -rf /root/.ssh/id_rsa
ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# Avoid complains from mmcrcluster
cat > /root/.ssh/config << EOF
Host $(hostname -f)
UserKnownHostsFile /dev/null
StrictHostKeyChecking no
EOF

echo "Installing base puppet modules"

puppet --version

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

# install grinder
wget https://www.dropbox.com/s/2s974oqhyttgdjh/grinder-cnaf-3.11-binary.tar.gz
tar -C /opt -xvzf grinder-cnaf-3.11-binary.tar.gz
rm -f grinder-cnaf-3.11-binary.tar.gz

echo 'export X509_USER_PROXY="/tmp/x509up_u$(id -u)"'>/etc/profile.d/x509_user_proxy.sh
cat /etc/profile.d/x509_user_proxy.sh

echo 'export GRINDER_HOME="/opt/grinder-3.11"'>/etc/profile.d/grinder.sh
cat /etc/profile.d/grinder.sh