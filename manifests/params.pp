# Class: mrepo::params
#
# This class provides default options for mrepo that can be overridden as well
# as validating overridden parameters.
#
# Parameters:
#   [*src_root*]      - The location to store the mrepo mirror data. Defaults to /var/mrepo.
#   [*www_root*]      - The location of the mrepo document root. Defaults to /var/www/mrepo.
#   [*user*]          - The account to use for mirroring the files. Defaults to apache.
#   [*group*]         - The group to use for mirroring the files. Defaults to apache.
#   [*source*]        - The package source. Defaults to git. (git|package)
#   [*selinux*]       - Whether to update the selinux context for the mrepo document root.
#                       Defaults to the selinux fact.
#   [*rhn*]           - Whether to install redhat dependencies or not. Defaults to false.
#   [*rhn_username*]  - The Redhat Network username. Must be set if the param rhn is true.
#   [*rhn_password*]  - The Redhat Network password. Must be set if the param rhn is true.
#
# Actions:
#
# Requires:
#   - puppetlabs-stdlib
#
# Sample Usage:
#
# node default {
#   class { "mrepo::params":
#     src_root     => '/srv/mrepo',
#     www_root     => '/srv/www/mrepo',
#     user         => 'www-user',
#     source       => 'package',
#     rhn          => true,
#     rhn_username => 'user',
#     rhn_password => 'pass',
#   }
# }
class mrepo::params (
  $src_root     = "/var/mrepo",
  $www_root     = "/var/www/mrepo",
  $user         = "apache",
  $group        = "apache",
  $source       = "git",
  $selinux      = undef,
  $rhn          = false,
  $rhn_username = undef,
  $rhn_password = undef
) {
  validate_re($source, "^git$|^package$")
  validate_bool($rhn)

  if $rhn {
    validate_re($rhn_username, ".+")
    validate_re($rhn_password, ".+")
  }


  # Validate selinux usage. If manually set, validate as a bool and use that value.
  # If undefined and selinux is present and not disabled, use selinux.
  case $mrepo::params::selinux {
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
}
