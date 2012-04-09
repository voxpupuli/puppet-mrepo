# This define creates and manages a redhat mrepo repository.
#
# == Parameters
#
# [*rhn*]
# Whether to generate rhn metadata for these repos.
# Default: false
#
# [*rhnrelease*]
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
  $repotitle  = $name
) {
  include mrepo
  include mrepo::params

  mrepo::repo { $name:
    ensure    => $ensure,
    release   => $release,
    arch      => $arch,
    urls      => $urls,
    metadata  => $metadata,
    update    => $update,
    hour      => $hour,
    iso       => $iso,
    repotitle => $repotitle,
  }

  case $ensure {
    present: {
      $user  = $mrepo::params::user
      $group = $mrepo::params::group

      file {
      "${mrepo::params::src_root}/${name}/deviceid":
        ensure  => present,
        owner   => $user,
        group   => $group,
        mode    => "0640",
        backup  => false,
        content => $ncc_username;
      "${mrepo::params::src_root}/${name}/secret":
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
