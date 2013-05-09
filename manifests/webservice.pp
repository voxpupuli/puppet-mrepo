# This class installs and configures apache to serve mrepo repositories.
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
class mrepo::webservice(
  $ensure = 'present'
){
  include mrepo::params

  $user  = $mrepo::params::user
  $group = $mrepo::params::group
  $docroot = $mrepo::params::www_root
  $servername = $mrepo::params::www_servername

  case $ensure {
    present: {
      include apache

      file { $docroot:
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => '0755',
      }

      apache::vhost { "mrepo":
        priority        => "10",
        port            => "80",
        servername      => $servername,
        docroot         => $docroot,
        custom_fragment => template("${module_name}/apache.conf.erb"),
      }
    }
    absent: {
      apache::vhost { "mrepo":
        ensure  => $ensure,
        port    => "80",
        docroot => $docroot,
      }
    }
  }
}
