#!/bin/bash
adduser -r storm

yum install -y emi-storm-backend-mp \
emi-storm-frontend-mp \
emi-storm-globus-gridftp-mp \
emi-storm-srm-client-mp \
emi-storm-gridhttps-mp \
storm-webdav \
globus-gass-copy-progs \
lcg-util \
dcache-srmclient \
davix

mkdir -p /etc/storm/siteinfo
cp -r /vagrant/storm-siteinfo/* /etc/storm/siteinfo

# run yaim
/opt/glite/yaim/bin/yaim -c -s /etc/storm/siteinfo/storm.def \
-n se_storm_backend \
-n se_storm_frontend \
-n se_storm_gridftp \
-n se_storm_webdav

STORM_BE_JAR="/usr/share/java/storm-backend-server/storm-backend-server.jar"
STORM_DEVEL_JAR="/opt/storm/target/storm-backend-server.jar"

if [ -r ${STORM_DEVEL_JAR} ]; then
  rm ${STORM_BE_JAR}
  ln -s ${STORM_DEVEL_JAR} ${STORM_BE_JAR}
fi