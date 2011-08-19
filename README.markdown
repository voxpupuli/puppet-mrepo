# Puppet Mrepo #

This module creates and synchronizes rpm based repositories by managing mrepo.

## Synopsis ##

Install and configure a basic mrepo installation

    node default {
      class { "mrepo": }
    }

Override default values and enable redhat network support for use in other classes

    class { "mrepo::params":
      selinux       => true,
      rhn           => true,
      rhn_username  => "user",
      rhn_password  => "pass",
    }

Mirror multiple centos 5 repositories

    mrepo::repo { "centos5-x86_64":
      ensure    => present,
      update    => "nightly",
      repotitle => "CentOS 5.6 64 bit",
      arch      => "x86_64",
      release   => "5.6",
      urls      => {
        addons      => 'rsync://mirrors.kernel.org/centos/$release/addons/$arch/',
        centosplus  => 'rsync://mirrors.kernel.org/centos/$release/centosplus/$arch/',
        updates     => 'rsync://mirrors.kernel.org/centos/$release/updates/$arch/',
      }
    }

    mrepo::repo { "centos5-i386":
      ensure    => present,
      update    => "nightly",
      repotitle => "CentOS 5.6 64 bit",
      arch      => "i386",
      release   => "5.6",
      urls      => {
        addons      => 'rsync://mirrors.kernel.org/centos/$release/addons/$arch/',
        centosplus  => 'rsync://mirrors.kernel.org/centos/$release/centosplus/$arch/',
        updates     => 'rsync://mirrors.kernel.org/centos/$release/updates/$arch/',
      }
    }

Mirror multiple rhel channels

    mrepo::repo { "rhel6server-x86_64":
      ensure     => present,
      update     => "nightly",
      repotitle  => 'Red Hat Enterprise Linux Server $release ($arch)',
      rhn        => true,
      arch       => "x86_64",
      release    => "6",
      rhnrelease => "6Server",
      iso        => 'rhel-server-6.0-$arch-dvd.iso',
      urls       => {
        updates       => 'rhns:///rhel-$arch-server-6',
        vt            => 'rhns:///rhel-$arch-server-vt-6',
        supplementary => 'rhns:///rhel-$arch-server-supplementary-6',
        fasttrack     => 'rhns:///rhel-$arch-server-fasttrack-6',
        hts           => 'rhns:///rhel-$arch-server-hts-6',
        rhn-tools     => 'rhns:///rhn-tools-rhel-$arch-server-6',
      }
    }

## Usage ##

If you need to customize the mrepo default settings, include the mrepo::params
class and include the appropriate variables. Else, you should be able to use
the mrepo::repo by itself to instantiate repositories.

For class/define specific documentation, view the puppet doc in the given file.

## Prerequisites ##

This module expects the following modules to be available:

  - puppetlabs-apache
  - puppetlabs-stdlib
  - puppetlabs-vcsrepo

It also is configured for a redhat derived system and makes assumptions about
the available users and groups. Alternate parameters may override these
assumptions.

Mirror data can grow extremely large, so you will want to ensure that src\_root
is located on a large volume.

If you are planning on using ISOs, you will also need fuse-iso.

## Repository URL formatting ##

You can take advantage of the variables that mrepo itself supports when
defining a repository or ISO to mirror. Mrepo uses the following variables:

  - $dist is set to the title of the resource
  - $arch is set to the arch parameter
  - $nick is set to $dist-$arch
  - $repo is set to the key of the specific repository
  - $release is set to the release parameter

Note that these are variables within mrepo; if you are using them, make sure to
surround the string in single quotes so puppet doesn't try to expand them.

So this:

    mrepo::repo { "centos5-x86_64":
      ensure    => present,
      update    => "nightly",
      repotitle => "CentOS 5.6 64 bit",
      arch      => "x86_64",
      release   => "5.6",
      urls      => {
        addons      => 'rsync://mirrors.kernel.org/centos/$release/$repo/$arch/',
        centosplus  => 'rsync://mirrors.kernel.org/centos/$release/$repo/$arch/',
        updates     => 'rsync://mirrors.kernel.org/centos/$release/$repo/$arch/',
      }
    }

Is equivalent to this:

    mrepo::repo { "centos5-x86_64":
      ensure    => present,
      update    => "nightly",
      repotitle => "CentOS 5.6 64 bit",
      arch      => "x86_64",
      release   => "5.6",
        addons      => 'rsync://mirrors.kernel.org/centos/5.6/addons/x86_64/',
        centosplus  => 'rsync://mirrors.kernel.org/centos/5.6/centosplus/x86_64/',
        updates     => 'rsync://mirrors.kernel.org/centos/5.6/updates/x86_64/',
      }
    }

Be warned that you can make a repository with the name of 'release'; however,
this will overwrite the actual release variable. If you have a repository with
a name of release, change the key to something else, and explicitly define the
url instead of using a variable.

For full details on how mrepo is used, see [the mrepo usage
page](https://github.com/dagwieers/mrepo/blob/master/docs/usage.txt).

## Caveats ##

### SELinux ###

Default SELinux policy prevents the httpd context from manipulating loopback
devices without having an explicit httpd context. This can be corrected by
changing the context as a mount option for a regular mount. However, fuseiso
does not have the capability to change selinux contexts. If you are planning on
mounting ISOs, either do so as root, change the httpd context to permit fuseiso
to run using audit2allow, or disable SELinux. If neither of these are viable
options, you can locate and mirror an outside repository of the ISO data.

Further clarification of this issue can be found on [the repoforge tools
list](http://lists.repoforge.org/pipermail/tools/2007-July/000877.html).

### Fuse ISO ###

Fuse iso is not available in any yum repository. You will need to locate an RPM or source file and install it for yourself. In addition, if you are using a non-root user to mount the ISOs, you will need to ensure that the user is in the 'fuse' group.
