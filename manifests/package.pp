# This class installs mrepo from source or from the system package repository
#
# == Parameters
#
# None
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

  $user   = $mrepo::user
  $group  = $mrepo::group
  $source = $mrepo::source
  $proto  = $mrepo::git_proto
  $ensure = $mrepo::ensure_src

  case $source {
    'git': {
      vcsrepo { '/usr/src/mrepo':
        ensure   => $ensure,
        revision => 'HEAD',
        provider => 'git',
        source   => "${proto}://github.com/dagwieers/mrepo.git",
      }

      exec { 'Install mrepo from source':
        refreshonly => true,
        path        => '/usr/bin:/usr/sbin:/sbin:/bin',
        cwd         => '/usr/src/mrepo',
        refresh     => 'make install',
        subscribe   => Vcsrepo['/usr/src/mrepo'],
        logoutput   => on_failure,
      }
    }
    'package': {
      package { 'mrepo':
        ensure  => present,
      }
    }
    default: {
    }
  }

  # mrepo.conf template params
  #
  $src_root            = $mrepo::src_root
  $www_root            = $mrepo::www_root
  $rhn_username        = $mrepo::rhn_username
  $rhn_password        = $mrepo::rhn_password
  $rhnget_cleanup      = $mrepo::rhnget_cleanup
  $rhnget_download_all = $mrepo::rhnget_download_all
  $mailto              = $mrepo::mailto
  $http_proxy          = $mrepo::http_proxy
  $https_proxy         = $mrepo::https_proxy

  file { '/etc/mrepo.conf':
    ensure  => present,
    owner   => $user,
    group   => $group,
    mode    => '0640',
    content => template('mrepo/mrepo.conf.erb'),
  }

  file { '/etc/mrepo.conf.d':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { '/var/cache/mrepo':
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { $src_root:
    ensure => directory,
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }

  file { '/var/log/mrepo.log':
    ensure => file,
    owner  => $user,
    group  => $group,
    mode   => '0640',
  }

  # Packages needed to mirror files and generate mirror metadata
  package { ['lftp', 'createrepo']:
    ensure  => present,
  }
}
