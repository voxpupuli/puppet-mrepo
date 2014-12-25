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
  $ensure,
  $release,
  $arch,
  $ncc_username,
  $ncc_password,
  $urls       = {},
  $metadata   = 'repomd',
  $update     = 'nightly',
  $hour       = '0',
  $iso        = '',
  $repotitle  = $name,
  $typerelease = $release,
) {
  include mrepo::params

  # This Class needs testing... no SLES here....

  case $ensure {
    present: {
      $user  = $mrepo::params::user
      $group = $mrepo::params::group

      $real_name = mrepo_munge($name, $arch)
      $src_root_subdir = "${mrepo::params::src_root}/${real_name}"

      file {
      "${src_root_subdir}/deviceid":
        ensure  => present,
        owner   => $user,
        group   => $group,
        mode    => "0640",
        backup  => false,
        content => $ncc_username;
      "${src_root_subdir}/secret":
        ensure  => present,
        owner   => $user,
        group   => $group,
        mode    => "0640",
        backup  => false,
        content => $ncc_password;
      }
    }
  }
}
