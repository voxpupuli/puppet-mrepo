# Class: mrepo::package
#
# This class installs mrepo from source or from the system package repository
#
# Parameters:
#   Optional parameters can be found in the mrepo::params class
#
# Actions:
#   Installs mrepo in the manner specified by mrepo::params
#
# Requires:
#   - puppetlabs-vcsrepo
#
# Sample Usage:
#   This class does not need to be directly included
class mrepo::package {

  include mrepo::params

  $source = $mrepo::params::source

  case $source {
    git: {
      vcsrepo { "/usr/src/mrepo":
        ensure    => latest,
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
}
