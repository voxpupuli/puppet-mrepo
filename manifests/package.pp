# This class installs mrepo from source or from the system package repository
#
# == Parameters
#
# Optional parameters can be found in the mrepo::params class
#
# == Examples
#
# This class does not need to be directly included.
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs, unless otherwise noted
#
class mrepo::package {

  include mrepo::params

  $user   = $mrepo::params::user
  $group  = $mrepo::params::group
  $source = $mrepo::params::source

  case $source {
    git: {
      vcsrepo { "/usr/src/mrepo":
        ensure    => latest,
        revision  => 'HEAD',
        provider  => "git",
        source    => "git://github.com/dagwieers/mrepo.git",
      }

      exec { "Install mrepo from source":
        refreshonly => true,
        path        => "/usr/bin:/usr/sbin:/sbin:/bin",
        cwd         => "/usr/src/mrepo",
        refresh     => "make install",
        subscribe   => Vcsrepo["/usr/src/mrepo"],
        logoutput => on_failure,
      }
    }
    package: {
      package { "mrepo":
        ensure  => present,
      }
    }
  }

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
    "/var/log/mrepo.log":
      ensure  => file,
      owner   => $user,
      group   => $group,
      mode    => '0640';
  }

  # Packages needed to mirror files and generate mirror metadata
  package { ['lftp', 'createrepo']:
    ensure  => present,
  }
}
