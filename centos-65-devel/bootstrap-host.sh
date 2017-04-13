#!/bin/bash
set -e

echo "bootstrap-host ..."

# Install certificate
mkdir -p /etc/grid-security
mv /tmp/hostcert.pem /etc/grid-security/hostcert.pem
mv /tmp/hostkey.pem /etc/grid-security/hostkey.pem
chmod 644 /etc/grid-security/hostcert.pem
chmod 400 /etc/grid-security/hostkey.pem
chown root:root /etc/grid-security/hostcert.pem
chown root:root /etc/grid-security/hostkey.pem

echo "hostname -f => $(hostname -f)"

# remove conflict with storm installation
yum remove -y systemtap-runtime
groupdel stapusr
