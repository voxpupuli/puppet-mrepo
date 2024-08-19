# Changelog

All notable changes to this project will be documented in this file.
Each new release typically also includes the latest modulesync defaults.
These should not affect the functionality of the module.

## [v5.0.0](https://github.com/voxpupuli/puppet-mrepo/tree/v5.0.0) (2024-08-19)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v4.1.0...v5.0.0)

**Breaking changes:**

- Drop EoL Scientific Linux [\#142](https://github.com/voxpupuli/puppet-mrepo/pull/142) ([bastelfreak](https://github.com/bastelfreak))
- Drop Eol EL6 [\#140](https://github.com/voxpupuli/puppet-mrepo/pull/140) ([bastelfreak](https://github.com/bastelfreak))
- Drop Puppet 6 support [\#127](https://github.com/voxpupuli/puppet-mrepo/pull/127) ([bastelfreak](https://github.com/bastelfreak))

**Implemented enhancements:**

- Add EL9 support [\#141](https://github.com/voxpupuli/puppet-mrepo/pull/141) ([bastelfreak](https://github.com/bastelfreak))
- puppet/apache: Allow 12.x [\#134](https://github.com/voxpupuli/puppet-mrepo/pull/134) ([zilchms](https://github.com/zilchms))
- puppetlabs/vcsrepo: Allow 6.x [\#133](https://github.com/voxpupuli/puppet-mrepo/pull/133) ([zilchms](https://github.com/zilchms))
- puppet/archive: Allow 7.x [\#132](https://github.com/voxpupuli/puppet-mrepo/pull/132) ([zilchms](https://github.com/zilchms))
- Add Puppet 8 support [\#129](https://github.com/voxpupuli/puppet-mrepo/pull/129) ([bastelfreak](https://github.com/bastelfreak))
- puppetlabs/stdlib: Allow 9.x [\#128](https://github.com/voxpupuli/puppet-mrepo/pull/128) ([bastelfreak](https://github.com/bastelfreak))
- puppet/archive: allow 5.x [\#123](https://github.com/voxpupuli/puppet-mrepo/pull/123) ([bastelfreak](https://github.com/bastelfreak))

**Fixed bugs:**

- Fix use of `selinux` fact [\#112](https://github.com/voxpupuli/puppet-mrepo/pull/112) ([alexjfisher](https://github.com/alexjfisher))
- Fix datatype of attribute metadata [\#111](https://github.com/voxpupuli/puppet-mrepo/pull/111) ([mrolli](https://github.com/mrolli))

**Merged pull requests:**

- Remove legacy top-scope syntax [\#130](https://github.com/voxpupuli/puppet-mrepo/pull/130) ([smortex](https://github.com/smortex))
- Allow stdlib 8.0.0 [\#124](https://github.com/voxpupuli/puppet-mrepo/pull/124) ([smortex](https://github.com/smortex))
- modulesync 3.0.0 & puppet-lint updates [\#116](https://github.com/voxpupuli/puppet-mrepo/pull/116) ([bastelfreak](https://github.com/bastelfreak))
- delete legacy travis directory [\#113](https://github.com/voxpupuli/puppet-mrepo/pull/113) ([bastelfreak](https://github.com/bastelfreak))

## [v4.1.0](https://github.com/voxpupuli/puppet-mrepo/tree/v4.1.0) (2019-11-18)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v4.0.0...v4.1.0)

**Implemented enhancements:**

- Add datatypes & multiple enhancements [\#107](https://github.com/voxpupuli/puppet-mrepo/pull/107) ([genebean](https://github.com/genebean))

**Fixed bugs:**

- Remove SymLinksIfOwnerMatch from template [\#102](https://github.com/voxpupuli/puppet-mrepo/pull/102) ([mrolli](https://github.com/mrolli))

**Merged pull requests:**

- allow puppetlabs/vcsrepo 3.x [\#108](https://github.com/voxpupuli/puppet-mrepo/pull/108) ([bastelfreak](https://github.com/bastelfreak))
- Allow `puppetlabs/apache` 5.x, `puppetlabs/stdlib` 6.x and `puppet/archive` 4.x [\#105](https://github.com/voxpupuli/puppet-mrepo/pull/105) ([alexjfisher](https://github.com/alexjfisher))
- Allow puppetlabs/apache 4.x [\#104](https://github.com/voxpupuli/puppet-mrepo/pull/104) ([mrolli](https://github.com/mrolli))

## [v4.0.0](https://github.com/voxpupuli/puppet-mrepo/tree/v4.0.0) (2019-05-02)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v3.1.1...v4.0.0)

**Breaking changes:**

- modulesync 2.5.1 and drop Puppet 4 [\#100](https://github.com/voxpupuli/puppet-mrepo/pull/100) ([bastelfreak](https://github.com/bastelfreak))
- Manage iso directory within mrepo::iso \(requires puppet/archive, drop puppet/staging\) [\#97](https://github.com/voxpupuli/puppet-mrepo/pull/97) ([mrolli](https://github.com/mrolli))

**Merged pull requests:**

- modulesync 2.2.0 and allow puppet 6.x [\#96](https://github.com/voxpupuli/puppet-mrepo/pull/96) ([bastelfreak](https://github.com/bastelfreak))

## [v3.1.1](https://github.com/voxpupuli/puppet-mrepo/tree/v3.1.1) (2018-09-07)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v3.1.0...v3.1.1)

**Merged pull requests:**

- allow puppetlabs/stdlib 5.x [\#93](https://github.com/voxpupuli/puppet-mrepo/pull/93) ([bastelfreak](https://github.com/bastelfreak))
- allow puppet/staging 3.x & puppetlabs/apache 3.x [\#91](https://github.com/voxpupuli/puppet-mrepo/pull/91) ([bastelfreak](https://github.com/bastelfreak))
- Remove docker nodesets [\#87](https://github.com/voxpupuli/puppet-mrepo/pull/87) ([bastelfreak](https://github.com/bastelfreak))
- bump puppet to latest supported version 4.10.0 [\#83](https://github.com/voxpupuli/puppet-mrepo/pull/83) ([bastelfreak](https://github.com/bastelfreak))

## [v3.1.0](https://github.com/voxpupuli/puppet-mrepo/tree/v3.1.0) (2017-11-27)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v3.0.0...v3.1.0)

**Merged pull requests:**

- Update metadata dependencies for puppet5 support [\#78](https://github.com/voxpupuli/puppet-mrepo/pull/78) ([alexjfisher](https://github.com/alexjfisher))

## [v3.0.0](https://github.com/voxpupuli/puppet-mrepo/tree/v3.0.0) (2017-10-11)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v2.1.0...v3.0.0)

**Breaking changes:**

- BREAKING: Drop puppet 3 support. Replace validate\_\* with datatypes [\#75](https://github.com/voxpupuli/puppet-mrepo/pull/75) ([bastelfreak](https://github.com/bastelfreak))

**Closed issues:**

- Module will not install [\#72](https://github.com/voxpupuli/puppet-mrepo/issues/72)

**Merged pull requests:**

- Fix github license detection [\#73](https://github.com/voxpupuli/puppet-mrepo/pull/73) ([alexjfisher](https://github.com/alexjfisher))
- enable mrepo service by default [\#68](https://github.com/voxpupuli/puppet-mrepo/pull/68) ([PascalBourdier](https://github.com/PascalBourdier))
- Refactors UUID exec to use fqdn\_uuid function [\#60](https://github.com/voxpupuli/puppet-mrepo/pull/60) ([petems](https://github.com/petems))

## [v2.1.0](https://github.com/voxpupuli/puppet-mrepo/tree/v2.1.0) (2017-01-13)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v2.0.1...v2.1.0)

**Closed issues:**

- selinux context incorrect for centos 7.2.1151 [\#51](https://github.com/voxpupuli/puppet-mrepo/issues/51)
- Major version bump to remove older parameters [\#43](https://github.com/voxpupuli/puppet-mrepo/issues/43)
- Refactor to use param pattern [\#42](https://github.com/voxpupuli/puppet-mrepo/issues/42)

**Merged pull requests:**

- modulesync 0.16.7 [\#64](https://github.com/voxpupuli/puppet-mrepo/pull/64) ([bastelfreak](https://github.com/bastelfreak))
- Set min version\_requirement for Puppet + deps [\#63](https://github.com/voxpupuli/puppet-mrepo/pull/63) ([juniorsysadmin](https://github.com/juniorsysadmin))
- modulesync 0.16.6 [\#62](https://github.com/voxpupuli/puppet-mrepo/pull/62) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 0.16.4 [\#61](https://github.com/voxpupuli/puppet-mrepo/pull/61) ([bastelfreak](https://github.com/bastelfreak))
- Refactor to use the params pattern [\#56](https://github.com/voxpupuli/puppet-mrepo/pull/56) ([petems](https://github.com/petems))
- modulesync 0.16.3 [\#55](https://github.com/voxpupuli/puppet-mrepo/pull/55) ([bastelfreak](https://github.com/bastelfreak))
- modulesync 0.15.0 [\#54](https://github.com/voxpupuli/puppet-mrepo/pull/54) ([bastelfreak](https://github.com/bastelfreak))
- Update based on voxpupuli/modulesync\_config 0.14.1 [\#53](https://github.com/voxpupuli/puppet-mrepo/pull/53) ([dhoppe](https://github.com/dhoppe))
- Parameterized the selinux context: https://github.com/voxpupuli/puppe… [\#52](https://github.com/voxpupuli/puppet-mrepo/pull/52) ([mlosapio](https://github.com/mlosapio))
- modulesync 0.13.0 [\#50](https://github.com/voxpupuli/puppet-mrepo/pull/50) ([bbriggs](https://github.com/bbriggs))
- Modulesync 0.12.7 [\#49](https://github.com/voxpupuli/puppet-mrepo/pull/49) ([alexjfisher](https://github.com/alexjfisher))
- Fix Puppetforge badge [\#48](https://github.com/voxpupuli/puppet-mrepo/pull/48) ([alexjfisher](https://github.com/alexjfisher))

## [v2.0.1](https://github.com/voxpupuli/puppet-mrepo/tree/v2.0.1) (2016-09-16)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v2.0.0...v2.0.1)

**Merged pull requests:**

- Release 2.0.1 [\#47](https://github.com/voxpupuli/puppet-mrepo/pull/47) ([alexjfisher](https://github.com/alexjfisher))
- Add travis secret [\#46](https://github.com/voxpupuli/puppet-mrepo/pull/46) ([alexjfisher](https://github.com/alexjfisher))

## [v2.0.0](https://github.com/voxpupuli/puppet-mrepo/tree/v2.0.0) (2016-09-16)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/1.2.1...v2.0.0)

**Closed issues:**

- master not working since last commit [\#13](https://github.com/voxpupuli/puppet-mrepo/issues/13)

**Merged pull requests:**

- Release 2.0.0 [\#45](https://github.com/voxpupuli/puppet-mrepo/pull/45) ([alexjfisher](https://github.com/alexjfisher))
- Add new `rhnget` options [\#44](https://github.com/voxpupuli/puppet-mrepo/pull/44) ([alexjfisher](https://github.com/alexjfisher))
- Add the most basic of rspec-puppet tests [\#41](https://github.com/voxpupuli/puppet-mrepo/pull/41) ([alexjfisher](https://github.com/alexjfisher))
- Modulesync [\#39](https://github.com/voxpupuli/puppet-mrepo/pull/39) ([alexjfisher](https://github.com/alexjfisher))
- Update README and metadata.json after VP migration [\#38](https://github.com/voxpupuli/puppet-mrepo/pull/38) ([alexjfisher](https://github.com/alexjfisher))
- Add `mailfrom` and `smtpserver` parameters [\#37](https://github.com/voxpupuli/puppet-mrepo/pull/37) ([ghost](https://github.com/ghost))

## [1.2.1](https://github.com/voxpupuli/puppet-mrepo/tree/1.2.1) (2016-04-26)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/1.2.0...1.2.1)

**Merged pull requests:**

- Prep for 1.2.1 release [\#32](https://github.com/voxpupuli/puppet-mrepo/pull/32) ([HelenCampbell](https://github.com/HelenCampbell))
- Shorten summary [\#31](https://github.com/voxpupuli/puppet-mrepo/pull/31) ([petems](https://github.com/petems))
- \(maint\) module does not unmount ISOs [\#30](https://github.com/voxpupuli/puppet-mrepo/pull/30) ([shermdog](https://github.com/shermdog))
- \(MODULES-2950\) Remove non-root user cron jobs [\#29](https://github.com/voxpupuli/puppet-mrepo/pull/29) ([shermdog](https://github.com/shermdog))

## [1.2.0](https://github.com/voxpupuli/puppet-mrepo/tree/1.2.0) (2015-08-12)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/1.1.1...1.2.0)

**Merged pull requests:**

- Release 1.2.0 [\#27](https://github.com/voxpupuli/puppet-mrepo/pull/27) ([hunner](https://github.com/hunner))
- only include the `ip` parameter in the apache vhost if $ip\_based is true [\#26](https://github.com/voxpupuli/puppet-mrepo/pull/26) ([ghost](https://github.com/ghost))
- Explicitly scope $mrepo::params::use\_selinux [\#25](https://github.com/voxpupuli/puppet-mrepo/pull/25) ([smarlow](https://github.com/smarlow))
- Fix syntax error [\#24](https://github.com/voxpupuli/puppet-mrepo/pull/24) ([arioch](https://github.com/arioch))
- Add ip-based vhost [\#23](https://github.com/voxpupuli/puppet-mrepo/pull/23) ([arioch](https://github.com/arioch))
- fix smart quote [\#22](https://github.com/voxpupuli/puppet-mrepo/pull/22) ([underscorgan](https://github.com/underscorgan))
- Add metadata summary in Modulefile per FM-1523 [\#20](https://github.com/voxpupuli/puppet-mrepo/pull/20) ([lrnrthr](https://github.com/lrnrthr))
- RedHat Network fixes and documentation [\#18](https://github.com/voxpupuli/puppet-mrepo/pull/18) ([esalberg](https://github.com/esalberg))
- fix repo variable; 'name' was confused. [\#17](https://github.com/voxpupuli/puppet-mrepo/pull/17) ([easescript](https://github.com/easescript))
- No guarantee that 'mrepo::repos' will be included [\#15](https://github.com/voxpupuli/puppet-mrepo/pull/15) ([hakamadare](https://github.com/hakamadare))
- Enable specifying port and priority for vhost [\#14](https://github.com/voxpupuli/puppet-mrepo/pull/14) ([hakamadare](https://github.com/hakamadare))
- Mrepo cmd params [\#12](https://github.com/voxpupuli/puppet-mrepo/pull/12) ([zipkid](https://github.com/zipkid))
- Mrepo reorg 06 [\#11](https://github.com/voxpupuli/puppet-mrepo/pull/11) ([zipkid](https://github.com/zipkid))
- Fix two minor items which make module unusable by default [\#8](https://github.com/voxpupuli/puppet-mrepo/pull/8) ([rhysrhaven](https://github.com/rhysrhaven))

## [1.1.1](https://github.com/voxpupuli/puppet-mrepo/tree/1.1.1) (2013-05-09)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/1.1.0...1.1.1)

## [1.1.0](https://github.com/voxpupuli/puppet-mrepo/tree/1.1.0) (2012-10-03)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/1.0.0...1.1.0)

**Merged pull requests:**

- Release of 1.1.0 [\#7](https://github.com/voxpupuli/puppet-mrepo/pull/7) ([adrienthebo](https://github.com/adrienthebo))

## [1.0.0](https://github.com/voxpupuli/puppet-mrepo/tree/1.0.0) (2012-08-28)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v0.1.3...1.0.0)

## [v0.1.3](https://github.com/voxpupuli/puppet-mrepo/tree/v0.1.3) (2012-02-12)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v0.1.2...v0.1.3)

**Merged pull requests:**

- Update Modulefile dependency information [\#4](https://github.com/voxpupuli/puppet-mrepo/pull/4) ([adrienthebo](https://github.com/adrienthebo))

## [v0.1.2](https://github.com/voxpupuli/puppet-mrepo/tree/v0.1.2) (2011-12-14)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v0.1.1...v0.1.2)

## [v0.1.1](https://github.com/voxpupuli/puppet-mrepo/tree/v0.1.1) (2011-09-16)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/v0.1.0...v0.1.1)

**Merged pull requests:**

- Fixes typos in the Modulefile [\#3](https://github.com/voxpupuli/puppet-mrepo/pull/3) ([ody](https://github.com/ody))

## [v0.1.0](https://github.com/voxpupuli/puppet-mrepo/tree/v0.1.0) (2011-09-16)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/0.1.0...v0.1.0)

**Merged pull requests:**

- First release of mrepo [\#2](https://github.com/voxpupuli/puppet-mrepo/pull/2) ([adrienthebo](https://github.com/adrienthebo))

## [0.1.0](https://github.com/voxpupuli/puppet-mrepo/tree/0.1.0) (2011-09-15)

[Full Changelog](https://github.com/voxpupuli/puppet-mrepo/compare/25944b8072f0cfa0f5bd27b32dbe58e784ea8edf...0.1.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
