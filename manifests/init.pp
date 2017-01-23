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
  $src_root             = $::mrepo::params::src_root,
  $www_root             = $::mrepo::params::www_root,
  $www_servername       = $::mrepo::params::www_servername,
  $www_ip               = $::mrepo::params::www_ip,
  $www_ip_based         = $::mrepo::params::www_ip_based,
  $user                 = $::mrepo::params::user,
  $group                = $::mrepo::params::group,
  $source               = $::mrepo::params::source,
  $ensure_src           = $::mrepo::params::ensure_src,
  $selinux              = $::mrepo::params::selinux,
  $rhn                  = $::mrepo::params::rhn,
  $rhn_config           = $::mrepo::params::rhn_config,
  $rhn_username         = $::mrepo::params::rhn_username,
  $rhn_password         = $::mrepo::params::rhn_password,
  $rhnget_cleanup       = $::mrepo::params::rhnget_cleanup,
  $rhnget_download_all  = $::mrepo::params::rhnget_download_all,
  $genid_command        = $::mrepo::params::genid_command,
  $mailto               = $::mrepo::params::mailto,
  $mailfrom             = $::mrepo::params::mailfrom,
  $smtpserver           = $::mrepo::params::smtpserver,
  $git_proto            = $::mrepo::params::git_proto,
  $descriptions         = $::mrepo::params::descriptions,
  $http_proxy           = $::mrepo::params::http_proxy,
  $https_proxy          = $::mrepo::params::https_proxy,
  $priority             = $::mrepo::params::priority,
  $port                 = $::mrepo::params::port,
  $selinux_context      = $::mrepo::params::selinux_context,
  $service_enable       = $::mrepo::params::service_enable,
) inherits ::mrepo::params {

  validate_re($source, '^git$|^package$')
  validate_re($git_proto, '^git$|^https$')
  validate_re($priority, '^\d+$')
  validate_re($port, '^\d+$')
  validate_bool($rhn)
  validate_hash($descriptions)

  if $mailto {
    validate_email_address($mailto)
  }
  if $mailfrom {
    validate_email_address($mailfrom)
  }

  if $rhn {
    validate_re($rhn_username, '.+')
    validate_re($rhn_password, '.+')
  }

  if $rhnget_cleanup != undef {
    validate_bool($rhnget_cleanup)
  }
  if $rhnget_download_all != undef {
    validate_bool($rhnget_download_all)
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
      validate_bool($selinux)
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

