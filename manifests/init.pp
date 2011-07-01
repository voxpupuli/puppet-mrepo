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

  include mrepo::params
  include mrepo::package
  include mrepo::rhn
  include mrepo::webservice
  include mrepo::selinux

  Class['mrepo::package']    -> Class['mrepo::webservice']
  Class['mrepo::package']    -> Class['mrepo::rhn']
  Class['mrepo']             -> Mrepo::Repo <| |>
  Class['mrepo']             -> Class['mrepo::selinux']

  $user = $mrepo::params::user
  $group = $mrepo::params::group

  file { "/etc/mrepo.conf":
      ensure  => present,
      owner   => $user,
      group   => $group,
      mode    => '0640',
      content => template("mrepo/mrepo.conf.erb"),
  }

  file {
    "/etc/mrepo.conf.d":
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755';
    "/var/cache/mrepo":
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755';
    $mrepo::params::src_root:
      ensure  => directory,
      owner   => $user,
      group   => $group,
      mode    => '0755';
  }

  package {
    "lftp":
      ensure  => present;
    "createrepo":
      ensure  => present;
  }
}
