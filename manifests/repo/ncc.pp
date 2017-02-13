# This define creates and manages a SLE mrepo repository.
#
# == Parameters
#
# [*ncc_username*]
# The ncc username, which can be found in /etc/zypp.d/NCCCredentials
#
# [*ncc_password*]
# The ncc password, which can be found in /etc/zypp.d/NCCCredentials
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
define mrepo::repo::ncc (
  Enum['present', 'absent'] $ensure,
  String[1] $release,
  Mrepo::Arch $arch,
  String[1] $ncc_username,
  String[1] $ncc_password,
  Hash[String, String] $urls        = {},
  String[1] $metadata               = 'repomd',
  Mrepo::Update $update             = 'nightly',
  Variant[String[1], Integer] $hour = '0',
  Optional[String[1]] $iso          = undef,
  String[1] $repotitle              = $name,
  Optional[String[1]] $typerelease  = $release,
) {
  include mrepo

  # This Class needs testing... no SLES here....

  if $ensure == 'present' {
    $user  = $mrepo::user
    $group = $mrepo::group

    $real_name = mrepo_munge($name, $arch)
    $src_root_subdir = "${mrepo::src_root}/${real_name}"

    file { "${src_root_subdir}/deviceid":
      ensure  => present,
      owner   => $user,
      group   => $group,
      mode    => '0640',
      backup  => false,
      content => $ncc_username,
    }

    file { "${src_root_subdir}/secret":
      ensure  => present,
      owner   => $user,
      group   => $group,
      mode    => '0640',
      backup  => false,
      content => $ncc_password,
    }
  }
}
