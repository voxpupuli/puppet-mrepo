# This class installs mrepo and all dependencies.
#
# Directly including this class is optional; if you instantiate an mrepo::repo
# the necessary dependencies will be pulled in. If you plan on managing mirrors
# outside of puppet and only want dependencies to be installed, then include
# this class.
#
# Parameters:
# [*src_root*]
# The path to store the mrepo mirror data.
# Default: /var/mrepo
#
# [*www_root*]
# The path of the mrepo html document root.
# Default: /var/www/mrepo
#
# [*www_ip*]
# Which IP address to use when www_ip_based is set.
# Default: $::ipaddress
#
# [*www_ip_based*]
# Whether to use IP-based virtual hosts or not.
# Default: false
#
# [*www_ensure*]
# Ensure apache vhost for mrepo has the given state.
# Default: present
#
# [*user*]
# The account to use for mirroring the files.
# Default: apache
#
# [*group*]
# The group to use for mirroring the files.
# Default: apache
#
# [*source*]
# The package source.
# Default: package
# Values: git, package
#
# [*ensure_src*]
# Ensure value for the package source.
# Note that with source set to 'git', setting ensure_src to 'latest'
#  may cause module-removed source files (e.g. httpd mrepo.conf) to be restored
# Default: latest
# Values: latest, present, absent
#
# [*selinux*]
# Whether to update the selinux context for the mrepo document root.
# Default: the selinux fact.
# Values: true, false
#
# [*rhn*]
# Whether to install RedHat dependencies or not. Defaults to false.
# Default: false
# Values: true, false
#
# [*rhn_config*]
# Whether to install RedHat dependencies for RHN on RHEL. Defaults to false.
# Note: Irrelevant (assumed true) for CentOS servers with rhn=true.
# Default: false
# Values: true, false
#
# [*rhn_username*]
# The Redhat Network username. Must be set if the param rhn is true.
#
# [*rhn_password*]
# The Redhat Network password. Must be set if the param rhn is true.
#
# [*rhnget_cleanup*]
# Clean up packages that are not on the sending side?
# Default: undef
# Values: undef, true, false
#
# [*rhnget_download_all*]
# Download older versions of packages?
# Default: undef
# Values: undef, true, false
#
# [*genid_command*]
# The base command to use to generate a systemid for RHN (mrepo::repo::rhn).
# Default: /usr/bin/gensystemid
#
# [*mailto*]
# The email recipient for mrepo updates. Defaults to unset, meaning no email will be sent.
#
# [*mailfrom*]
# The email sender for mrepo updates. Defaults to unset, meaning mrepo will use its default of `mrepo@`_fqdn_.
#
# [*smtpserver*]
# The SMTP server to use for sending update emails.  Defaults to unset, meaning mrepo will use its default of `localhost`.
#
# == Examples
#
# node default {
#   class { "mrepo":
#     src_root     => '/srv/mrepo',
#     www_root     => '/srv/www/mrepo',
#     user         => 'www-user',
#     source       => 'package',
#     rhn          => true,
#     rhn_username => 'user',
#     rhn_password => 'pass',
#   }
# }
#
# == Examples
#
#  node default {
#    class { "mrepo": }
#  }
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs, unless otherwise noted
#
class mrepo (
  $src_root                              = $::mrepo::params::src_root,
  $www_root                              = $::mrepo::params::www_root,
  $www_servername                        = $::mrepo::params::www_servername,
  $www_ip                                = $::mrepo::params::www_ip,
  $www_ip_based                          = $::mrepo::params::www_ip_based,
  Enum['present', 'absent'] $www_ensure  = $::mrepo::params::www_ensure,
  $user                                  = $::mrepo::params::user,
  $group                                 = $::mrepo::params::group,
  Enum['git', 'package'] $source         = $::mrepo::params::source,
  $ensure_src                            = $::mrepo::params::ensure_src,
  Optional[Boolean] $selinux             = $::mrepo::params::selinux,
  Boolean $rhn                           = $::mrepo::params::rhn,
  $rhn_config                            = $::mrepo::params::rhn_config,
  Optional[String] $rhn_username         = $::mrepo::params::rhn_username,
  Optional[String] $rhn_password         = $::mrepo::params::rhn_password,
  Optional[Boolean] $rhnget_cleanup      = $::mrepo::params::rhnget_cleanup,
  Optional[Boolean] $rhnget_download_all = $::mrepo::params::rhnget_download_all,
  $genid_command                         = $::mrepo::params::genid_command,
  Optional[String] $mailto               = $::mrepo::params::mailto,
  Optional[String] $mailfrom             = $::mrepo::params::mailfrom,
  $smtpserver                            = $::mrepo::params::smtpserver,
  Enum['git', 'https'] $git_proto        = $::mrepo::params::git_proto,
  Hash $descriptions                     = $::mrepo::params::descriptions,
  $http_proxy                            = $::mrepo::params::http_proxy,
  $https_proxy                           = $::mrepo::params::https_proxy,
  Integer $priority                      = $::mrepo::params::priority,
  Integer $port                          = $::mrepo::params::port,
  $selinux_context                       = $::mrepo::params::selinux_context,
  $service_enable                        = $::mrepo::params::service_enable,
  $service_manage                        = $::mrepo::params::service_manage,
) inherits ::mrepo::params {

  if $rhn {
    assert_type(String[1], $rhn_username)
    assert_type(String[1], $rhn_password)
  }

  # Validate selinux usage. If manually set, validate as a bool and use that value.
  # If undefined and selinux is present and not disabled, use selinux.
  case $mrepo::selinux {
    undef: {
      case $::selinux {
        'enforcing', 'permissive': {
          $use_selinux = true
        }
        'disabled', default: {
          $use_selinux = false
        }
      }
    }
    default: {
      assert_type(Boolean, $selinux)
      $use_selinux = $selinux
    }
  }

  contain ::mrepo::package
  contain ::mrepo::rhn
  contain ::mrepo::service
  contain ::mrepo::webservice
  contain ::mrepo::selinux

  Class['mrepo::package']    -> Class['mrepo::service']
  Class['mrepo::package']    -> Class['mrepo::webservice']
  Class['mrepo::package']    -> Class['mrepo::rhn']
  Class['mrepo::package']    -> Class['mrepo::selinux']
  Class['mrepo::webservice'] -> Class['mrepo::selinux']

}

