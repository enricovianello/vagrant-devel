#!/bin/bash
set -e

echo "bootstrap-puppet ..."

# Install puppet
echo "Install puppet ..."
if rpm -qa | grep -q puppetlabs; then
  echo "puppetlabs already installed"
else
  rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
fi
yum clean all
yum -y install puppet-server

echo "Installing base puppet modules ..."

puppet --version

puppet module install --force maestrodev-wget
puppet module install --force gini-archive
puppet module install --force puppetlabs-stdlib
puppet module install --force maestrodev-maven
puppet module install --force puppetlabs-java

echo "Fetching puppet modules from: https://github.com/cnaf ..."

if [ ! -e "ci-puppet-modules" ]; then
  git clone https://github.com/cnaf/ci-puppet-modules.git
else
  pushd ci-puppet-modules
  git pull
  popd
fi

cp -rf ci-puppet-modules/modules/* /etc/puppet/modules
