# Class: mrepo::webservice
#
# This class installs and configures apache to serve mrepo repositories.
#
# Requires:
#   - puppetlabs-apache
#
# Sample Usage:
#   This class does not need to be directly included
class mrepo::webservice {
  include apache
  include mrepo::params

  $user = $mrepo::params::user
  $group = $mrepo::params::group

  file { $mrepo::params::www_root:
    ensure  => directory,
    owner   => $user,
    group   => $group,
    mode    => '0755',
    require => Class['apache'],
  }

  apache::vhost { "mrepo":
    priority  => "10",
    port      => "80",
    docroot   => "/var/www/mrepo",
    template  => "mrepo/apache.conf.erb",
  }
}
