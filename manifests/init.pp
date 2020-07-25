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
# Default: $facts['networking']['ip']
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
  Stdlib::Absolutepath $src_root                  = $mrepo::params::src_root,
  Stdlib::Absolutepath $www_root                  = $mrepo::params::www_root,
  String[1] $www_servername                       = $mrepo::params::www_servername,
  Optional[Stdlib::IP::Address] $www_ip           = $mrepo::params::www_ip,
  Boolean $www_ip_based                           = $mrepo::params::www_ip_based,
  String[1] $user                                 = $mrepo::params::user,
  String[1] $group                                = $mrepo::params::group,
  Enum['git', 'package'] $source                  = $mrepo::params::source,
  Enum['latest', 'present', 'absent'] $ensure_src = $mrepo::params::ensure_src,
  Optional[Boolean] $selinux                      = $mrepo::params::selinux,
  Boolean $rhn                                    = $mrepo::params::rhn,
  Boolean $rhn_config                             = $mrepo::params::rhn_config,
  Optional[String[1]] $rhn_username               = $mrepo::params::rhn_username,
  Optional[String[1]] $rhn_password               = $mrepo::params::rhn_password,
  Optional[Boolean] $rhnget_cleanup               = $mrepo::params::rhnget_cleanup,
  Optional[Boolean] $rhnget_download_all          = $mrepo::params::rhnget_download_all,
  Stdlib::Absolutepath $genid_command             = $mrepo::params::genid_command,
  Optional[String[1]] $mailto                     = $mrepo::params::mailto,
  Optional[String[1]] $mailfrom                   = $mrepo::params::mailfrom,
  Optional[Stdlib::Host] $smtpserver              = $mrepo::params::smtpserver,
  Enum['git', 'https'] $git_proto                 = $mrepo::params::git_proto,
  Hash $descriptions                              = $mrepo::params::descriptions,
  Optional[Stdlib::HTTPUrl] $http_proxy           = $mrepo::params::http_proxy,
  Optional[Stdlib::HTTPUrl] $https_proxy          = $mrepo::params::https_proxy,
  Integer $priority                               = $mrepo::params::priority,
  Integer $port                                   = $mrepo::params::port,
  Optional[String[1]] $createrepo_options         = $mrepo::params::createrepo_options,
  String[1] $selinux_context                      = $mrepo::params::selinux_context,
  Boolean $service_enable                         = $mrepo::params::service_enable,
  Boolean $service_manage                         = $mrepo::params::service_manage,
) inherits mrepo::params {
  if $rhn {
    assert_type(String[1], $rhn_username)
    assert_type(String[1], $rhn_password)
  }

  # Validate selinux usage. If manually set, validate as a bool and use that value.
  # If undefined and selinux is present and not disabled, use selinux.
  case $mrepo::selinux {
    undef: {
      case fact('os.selinux.current_mode') {
        'enforcing', 'permissive': {
          $use_selinux = true
        }
        'disabled', default: {
          $use_selinux = false
        }
      }
    }
    default: {
      $use_selinux = $mrepo::selinux
    }
  }

  contain mrepo::package
  contain mrepo::rhn
  contain mrepo::service
  contain mrepo::webservice
  contain mrepo::selinux

  Class['mrepo::package']    -> Class['mrepo::service']
  Class['mrepo::package']    -> Class['mrepo::webservice']
  Class['mrepo::package']    -> Class['mrepo::rhn']
  Class['mrepo::package']    -> Class['mrepo::selinux']
  Class['mrepo::webservice'] -> Class['mrepo::selinux']
}
