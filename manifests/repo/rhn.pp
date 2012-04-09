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
define mrepo::repo::rhn (
  $ensure,
  $release,
  $arch,
  $urls       = {},
  $metadata   = 'repomd',
  $update     = 'nightly',
  $hour       = '0',
  $iso        = '',
  $rhnrelease = $release,
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
      exec { "Generate systemid $name - $arch":
        command   => "gensystemid -u ${mrepo::params::rhn_username} -p ${mrepo::params::rhn_password} --release ${rhnrelease} --arch ${arch} ${mrepo::params::src_root}/${name}",
        path      => [ "/bin", "/usr/bin" ],
        user      => $user,
        group     => $group,
        creates   => "${mrepo::params::src_root}/${name}/systemid",
        require   => [
          Class['mrepo::package'],
          Class['mrepo::rhn'],
        ],
        before    => Exec["Generate mrepo repo ${name}"],
        logoutput => on_failure,
      }
    }
  }
}
