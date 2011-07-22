# Define: mrepo::repo
#
# This define creates and manages an mrepo repository.
#
# Parameters:
#   [*ensure*]      - Creates or destroys the given repository (present|absent)
#   [*release*]     - The distribution release to mirror
#   [*arch*]        - The architecture of the release to mirror. (i386|x86_64)
#   [*urls*]        - A hash of repository names and URLs.
#   [*metadata*]    - The metadata type for the repository. Defaults to repomd.
#                     More than one value can be used in an array. (yum|apt|repomd)
#   [*update*]      - The schedule for updating. (now|nightly|weekly|never)
#                     Now will update the repo on every run of puppet. Be warned
#                     That this could be a very lengthy process.
#   [*iso*]         - The pattern of the ISO to mirror. Optional.
#   [*rhn*]         - Whether to generate rhn metadata for these repos. Defaults to false. Optional.
#   [*repotitle*]   - The human readable title of the repository. Optional.
#
# Actions:
#   Generates an mrepo repository file and will generate the initial repository.
#   If the update parameter is set to "now", the repository will be immediately
#   synchronized.
#
# Requires:
#
# Sample Usage:
#
# mrepo::repo { "centos5-x86_64":
#   ensure    => present,
#   arch      => "x86_64",
#   release   => "5.5",
#   repotitle => "CentOS 5.5 64 bit",
#   urls      => {
#     addons      => "http://mirrors.kernel.org/centos/5.6/addons/x86_64/",
#     centosplus  => "http://mirrors.kernel.org/centos/5.6/centosplus/x86_64/",
#     contrib     => "http://mirrors.kernel.org/centos/5.6/contrib/x86_64/",
#     extras      => "http://mirrors.kernel.org/centos/5.6/extras/x86_64/",
#     fasttrack   => "http://mirrors.kernel.org/centos/5.6/fasttrack/x86_64/",
#     updates     => "http://mirrors.kernel.org/centos/5.6/updates/x86_64/",
#   }
# }
#
# See Also:
#   mrepo usage: https://github.com/dagwieers/mrepo/blob/master/docs/usage.txt
define mrepo::repo (
  $ensure,
  $release,
  $arch,
  $urls       = {},
  $metadata   = 'repomd',
  $update     = 'nightly',
  $iso        = '',
  $rhn        = false,
  $repotitle  = undef
) {
  include mrepo

  validate_re($ensure, "^present$|^absent$")
  validate_re($update, "^now$|^nightly$|^weekly$|^never$")
  validate_bool($rhn)

  case $ensure {
    present: {

      $user = $mrepo::params::user
      $group = $mrepo::params::group
      if !$repotitle {
        $repotitle = $name
      }

      file { "/etc/mrepo.conf.d/$name.conf":
        ensure  => present,
        owner   => $user,
        group   => $group,
        content => template("mrepo/repo.conf.erb"),
        require => Class['mrepo'],
      }

      file { "${mrepo::params::src_root}/$name":
        ensure  => directory,
        owner   => $user,
        group   => $group,
        mode    => "0755",
        backup  => false,
        recurse => false,
      }

      exec { "Generate mrepo repo $name":
        command   => "mrepo -g $name",
        cwd       => $src_root,
        path      => [ "/usr/bin", "/bin" ],
        user      => $user,
        group     => $group,
        creates   => "${mrepo::params::www_root}/${name}",
        require   => Class['mrepo'],
        subscribe => File["/etc/mrepo.conf.d/$name.conf"],
        logoutput => on_failure,
      }

      case $update {
        now: {
          exec { "Synchronize repo $name":
            command   => "/usr/bin/mrepo -gu $name",
            cwd       => $src_root,
            path      => [ "/usr/bin", "/bin" ],
            user      => $user,
            group     => $group,
            timeout   => 0,
            require   => Class['mrepo'],
            logoutput => on_failure,
          }
          cron {
            "Nightly synchronize repo $name":
              ensure  => absent;
            "Weekly synchronize repo $name":
              ensure  => absent;
          }
        }
        nightly: {
          cron {
            "Nightly synchronize repo $name":
              ensure  => present,
              command => "/usr/bin/mrepo -u",
              hour    => "0",
              minute  => "0",
              user    => $user,
              require => Class['mrepo'];
            "Weekly synchronize repo $name":
              ensure  => absent;
          }
        }
        weekly: {
          cron {
            "Weekly synchronize repo $name":
              ensure  => present,
              command => "/usr/bin/mrepo -u",
              day     => "0",
              hour    => "0",
              minute  => "0",
              user    => $user,
              require => Class['mrepo'];
            "Nightly synchronize repo $name":
              ensure  => absent;
          }
        }
      }
      if $rhn == true {
        exec { "Generate systemid $name - $arch":
          command   => "gensystemid -u ${mrepo::params::rhn_username} -p ${mrepo::params::rhn_password} --release $release --arch $arch ${mrepo::params::src_root}/$name",
          path      => [ "/bin", "/usr/bin" ],
          user      => $user,
          group     => $group,
          creates   => "${mrepo::params::src_root}/$name/systemid",
          require   => Class['mrepo'],
          logoutput => on_failure,
        }
      }
    }
    absent: {
      file {
        "/etc/mrepo.conf.d/$name":
          backup  => false,
          recurse => false,
          force   => true,
          ensure  => absent;
        "${mrepo::params::src_root}/$name":
          backup  => false,
          recurse => false,
          force   => true,
          ensure  => absent;
      }
      cron {
        "Nightly synchronize repo $name":
          ensure  => absent;
        "Weekly synchronize repo $name":
          ensure  => absent;
      }
    }
  }
}
