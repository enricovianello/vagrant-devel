#!/bin/bash
set -e

# add SAs links
cd /storage/test.vo/
ln -s ../test.vo.2 testvo_to_testvo2

# fix db grants for root@'fqdn' if needed
HOSTNAME=`hostname -f`

source /etc/storm/siteinfo/storm.def

mysql -u root -p${MYSQL_PASSWORD} -e"GRANT ALL PRIVILEGES ON *.* TO 'root'@'${HOSTNAME}' IDENTIFIED BY '${MYSQL_PASSWORD}' WITH GRANT OPTION; FLUSH PRIVILEGES" > /dev/null 2> /dev/null
