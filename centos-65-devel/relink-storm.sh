#!/bin/bash
# set -x
STORM_BE_JAR="/usr/share/java/storm-backend-server/storm-backend-server.jar"
STORM_DEVEL_JAR="/opt/storm/storm-backend-server.jar"

if [ -r ${STORM_DEVEL_JAR} ]; then
  rm ${STORM_BE_JAR}
  ln -s ${STORM_DEVEL_JAR} ${STORM_BE_JAR}
fi
