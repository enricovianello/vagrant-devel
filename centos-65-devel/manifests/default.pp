# Please keep the following in the order
# in which they are listed.
include puppet-users
include puppet-gpfs-repo
include puppet-gpfs
include puppet-oracle-repo
include puppet-egi-trust-anchors
include puppet-test-ca
include puppet-infn-ca

# Other useful tools
include puppet-grinder
include puppet-robot-framework

# Project build dependencies
include puppet-storm-build-deps
include puppet-voms-build-deps
