# This define creates and manages a redhat mrepo repository.
#
# == Parameters
#
# [*rhn*]
# Whether to generate rhn metadata for these repos.
# Default: false
#
# [*typerelease*]
# The name of the RHN release as understood by mrepo. Optional.
#
# == Examples
#
# TODO
#
# Further examples can be found in the module README.
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2012 Puppet Labs, unless otherwise noted
#
define mrepo::repo::rhn (
  Enum['present', 'absent'] $ensure,
  String[1] $release,
  Mrepo::Arch $arch,
  Hash[String, String] $urls        = {},
  String[1] $metadata               = 'repomd',
  Mrepo::Update $update             = 'nightly',
  Variant[String[1], Integer] $hour = '0',
  Optional[String[1]] $iso          = undef,
  String[1] $repotitle              = $name,
  Optional[String[1]] $typerelease  = $release,
) {
  include mrepo::params

  $http_proxy    = $mrepo::http_proxy
  $https_proxy   = $mrepo::https_proxy
  $rhn_username  = $mrepo::rhn_username
  $rhn_password  = $mrepo::rhn_password
  $src_root      = $mrepo::src_root
  $user          = $mrepo::user
  $group         = $mrepo::group
  $genid_command = $mrepo::genid_command

  $sysid_command = "${genid_command}\s-r\s${typerelease}\s-u\s\'${rhn_username}\'\s-p\s\'${rhn_password}\'\s-a\s${arch}\s\'${src_root}/${name}\'"

  # Workaround for http://projects.puppetlabs.com/issues/19848
  if $http_proxy or $https_proxy {
    if $http_proxy and $https_proxy {
      $gen_env = ["http_proxy=${http_proxy}","https_proxy=${https_proxy}"]
    }
    elsif $http_proxy {
      $gen_env = "http_proxy=${http_proxy}"
    }
    elsif $https_proxy {
      $gen_env = "https_proxy=${https_proxy}"
    }
  }

  if $ensure == 'present' and $gen_env {
    exec { "Generate systemid ${name} - ${arch}":
      command     => $sysid_command,
      path        => ['/bin', '/usr/bin'],
      user        => $user,
      group       => $group,
      creates     => "${src_root}/${name}/systemid",
      require     => [
        Class['mrepo::package'],
        Class['mrepo::rhn'],
      ],
      before      => Exec["Generate mrepo repo ${name}"],
      logoutput   => on_failure,
      environment => $gen_env,
    }
  }
  elsif $ensure == 'present' {
    exec { "Generate systemid ${name} - ${arch}":
      command   => $sysid_command,
      path      => ['/bin', '/usr/bin'],
      user      => $user,
      group     => $group,
      creates   => "${src_root}/${name}/systemid",
      require   => [
        Class['mrepo::package'],
        Class['mrepo::rhn'],
      ],
      before    => Exec["Generate mrepo repo ${name}"],
      logoutput => on_failure,
    }
  }
}
