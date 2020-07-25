# This class installs dependencies for Redhat Network mirroring. This
# primarily handles the specifics of preparing a CentOS host to connect to
# the RHN.
#
# == Parameters
#
# Optional parameters can be found in the mrepo class
#
# == Examples
#
# This class does not need to be directly included
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs, unless otherwise noted
#
class mrepo::rhn {
  $group        = $mrepo::group
  $rhn          = $mrepo::rhn
  $rhn_config   = $mrepo::rhn_config

  if $rhn == true {
    package { 'pyOpenSSL':
      ensure  => present,
    }

    # CentOS does not have redhat network specific configuration files by default
    if $facts['os']['name'] == 'CentOS' or $rhn_config == true {
      file { '/etc/sysconfig/rhn':
        ensure => 'file',
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
      }

      # Generate UUID using the fqdn_uuid function from stdlib
      $rhnuuid_setting = fqdn_uuid($facts['networking']['fqdn'])

      file { '/etc/sysconfig/rhn/up2date-uuid':
        ensure  => 'file',
        replace => false,
        owner   => 'root',
        group   => $group,
        mode    => '0640',
        content => "rhnuuid=${rhnuuid_setting}",
      }

      file { '/etc/sysconfig/rhn/sources':
        ensure  => 'file',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => 'up2date default',
      }

      file { '/usr/share/mrepo/rhn/RHNS-CA-CERT':
        ensure => 'file',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/mrepo/RHNS-CA-CERT',
      }

      file { '/usr/share/rhn':
        ensure => directory,
        owner  => 'root',
        group  => 'root',
        mode   => '0755',
      }

      file { '/usr/share/rhn/RHNS-CA-CERT':
        ensure => link,
        target => '/usr/share/mrepo/rhn/RHNS-CA-CERT',
      }
    }
  }
}
