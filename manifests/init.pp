# Class: mrepo
#
# This class installs mrepo and all dependencies
#
# Parameters:
#   Optional parameters can be found in the mrepo::params class
#
# Actions:
#   Installs and configures mrepo to run on a system. Does not instantiate any
#   repositories by itself.
#
# Requires:
#   - puppetlabs-stdlib
#
# Sample Usage:
#
#  node default {
#    class { "mrepo": }
#  }
#
# Directly including this class is optional; if you instantiate an mrepo::repo
# the necessary dependencies will be pull in. If you plan on managing mirrors
# outside of puppet and only want dependencies to be installed, then include
# this class.
class mrepo {
  include mrepo::package
  include mrepo::rhn
  include mrepo::webservice
  include mrepo::selinux

  anchor { 'mrepo::begin':
    before => Class['mrepo::package'],
  }

  Class['mrepo::package']    -> Class['mrepo::webservice']
  Class['mrepo::package']    -> Class['mrepo::rhn']
  Class['mrepo::package']    -> Class['mrepo::selinux']
  Class['mrepo::webservice'] -> Class['mrepo::selinux']

  anchor { 'mrepo::end':
    require => [
      Class['mrepo::package'],
      Class['mrepo::webservice'],
      Class['mrepo::selinux'],
      Class['mrepo::rhn'],
    ],
  }
}
