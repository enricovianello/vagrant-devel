# Please keep the following in the order
# in which they are listed.

#include mwdevel_gpfs_repo

include mwdevel_gpfs
#class { 'mwdevel_gpfs':
#        version => '4.2.3-4',
#}

include mwdevel_oracle_repo
include mwdevel_egi_trust_anchors
include mwdevel_test_ca
include mwdevel_infn_ca
include mwdevel_test_vos

# Other useful tools
# include puppet-grinder
include mwdevel_robot_framework

# Project build dependencies
#include puppet-storm-build-deps
#include puppet-voms-build-deps
