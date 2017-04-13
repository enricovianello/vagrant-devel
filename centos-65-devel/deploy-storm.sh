#!/bin/bash

# install acl and extended attributes support
echo "Install StoRM prerequisites ..."
yum install -y attr acl fetch-crl

# run fetch-crl
echo "Run fetch-crl ..."
fetch-crl

WGET_OPTIONS="--no-check-certificate"
# use the STORM_REPO env variable for the repo, or default to the develop repo
STORM_REPO=${STORM_REPO:-http://italiangrid.github.io/storm/repo/storm_sl6.repo}

echo "Install UMD repositories ..."
# install UMD repositories
rpm --import http://repository.egi.eu/sw/production/umd/UMD-RPM-PGP-KEY
yum install -y http://repository.egi.eu/sw/production/umd/3/sl6/x86_64/updates/umd-release-3.14.3-1.el6.noarch.rpm

echo "Install StoRM Repo ..."
# install the storm repo
wget $WGET_OPTIONS $STORM_REPO -O /etc/yum.repos.d/storm.repo

# install
yum clean all

# add some users
echo "Add storm user ..."
adduser -r storm

# install storm packages
echo "Install StoRM packages ..."
yum install -y emi-storm-backend-mp emi-storm-frontend-mp emi-storm-globus-gridftp-mp storm-webdav storm-native-libs-gpfs

echo "Install StoRM test stuff ..."
yum install -y emi-storm-srm-client-mp globus-gass-copy-progs lcg-util dcache-srmclient davix

mkdir -p /etc/storm

if [ ! -e "storm-deployment-test" ]; then
  git clone https://github.com/italiangrid/storm-deployment-test.git
else
  pushd storm-deployment-test
  git pull
  popd
fi
cp -a storm-deployment-test/siteinfo /etc/storm/siteinfo

#STORM_BE_JAR="/usr/share/java/storm-backend-server/storm-backend-server.jar"
#STORM_DEVEL_JAR="/opt/storm/target/storm-backend-server.jar"

#if [ -r ${STORM_DEVEL_JAR} ]; then
#  rm ${STORM_BE_JAR}
#  ln -s ${STORM_DEVEL_JAR} ${STORM_BE_JAR}
#fi

# chown /storage
chown -R storm:storm /storage/test.vo

# run yaim
/opt/glite/yaim/bin/yaim -c -s /etc/storm/siteinfo/storm.def -n se_storm_backend -n se_storm_frontend -n se_storm_gridftp -n se_storm_webdav
