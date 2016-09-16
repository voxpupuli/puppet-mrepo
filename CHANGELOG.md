## 2016-09-16 Release 2.0.1

Version 2.0.0 was tagged but never released to the forge due to a travis configuration issue.
There are no other changes or fixes in this release.

  * [PR-46](https://github.com/voxpupuli/puppet-mrepo/pull/46) Add travis secret

## 2016-09-16 Release 2.0.0

This is the first release in [Vox Pupuli](https://voxpupuli.org/)'s [puppet](https://forge.puppet.com/puppet) namespace.
It is a new major release as support for ruby 1.8 has been dropped and there are some potential breaking changes to parameter defaults in `params.pp`

  * [PR-44](https://github.com/voxpupuli/puppet-mrepo/pull/44) New `rhnget_cleanup` and `rhnget_download_all` parameters.
  * [PR-37](https://github.com/voxpupuli/puppet-mrepo/pull/37) New `mailfrom` and `smtpserver` parameters.
  * [**BREAKING CHANGE**](https://github.com/voxpupuli/puppet-mrepo/pull/39) Ruby 1.8 support removed.

## 2016-04-26 Release 1.2.1

A small release to address some previous issues and errors.

  * Removed non-root user cron jobs
  * Fixed issue in which the grep string did not match the mount point of the ISO
  * The summary in metadata used to throw an error, it has been shortened to fix this

## 2015-08-12 Release 1.2.0

  * Add ability specify package source protocol other than git
  * Add ability to specify source version other than latest
  * Add ability to use ip_based vhost
  * Fix some RHN related issues.
  * Add ability to specify releases and release types (eg, 6Server)
  * Add ability to customize mrepo command, options, environment vars
  * Add `mrepo::repos` for hiera integration.

## 2013-05-09 Release 1.1.1

NOTE: This version requires puppetlabs/apache 0.6.0, which is a backwards
incompatible release. If you are using that module elsewhere then you'll need
to resolve the upgrade for apache first.

  * Manage /var/log/mrepo.log so that mrepo user can write to it while running
  * Remove dependency cycle when using mrepo with apache
  * Don't use `undef` for rhn username or password


## 2012-10-03 Release 1.1.0

  * Correct invalid Modulefile dependency
  * Changes to conform to style guide.
  * Allow tuning of email recipient
  * Add in mrepo::exports class
  * Add in support for creating NFS shares of mrepo disks. This is primarily
    needed for mirroring and building on SLES.

## 2012-08-28 Release 1.0.0

This is a backwards incompatible release.

  * Split out mirroring for RHN and NCC repositories, since they have
    nontrivial amounts of logic needed to authenticate to the mirror source.
  * Add hour parameter to mrepo::repo define to permit staggering
    synchronization time.
  * Add mrepo::iso define. This will copy ISOs from to the mrepo host for
    mirroring from ISOs. This adds a dependency on nanliu-staging
  * Clean up repository name munging by extracting the logic into a Puppet
    function.
  * Respect mrepo docroot for apache
