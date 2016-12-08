# This class provides default options for mrepo that can be overridden as well
# as validating overridden parameters.
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs unless otherwise noted
#
class mrepo::params (
  $src_root            = '/var/mrepo',
  $www_root            = '/var/www/mrepo',
  $www_servername      = 'mrepo',
  $www_ip              = $::ipaddress,
  $www_ip_based        = false,
  $user                = 'apache',
  $group               = 'apache',
  $source              = 'package',
  $ensure_src          = 'latest',
  $selinux             = undef,
  $rhn                 = false,
  $rhn_config          = false,
  $rhn_username        = '',
  $rhn_password        = '',
  $rhnget_cleanup      = undef,
  $rhnget_download_all = undef,
  $genid_command       = '/usr/bin/gensystemid',
  $mailto              = undef,
  $mailfrom            = undef,
  $smtpserver          = undef,
  $git_proto           = 'git',
  $descriptions        = {},
  $http_proxy          = '',
  $https_proxy         = '',
  $priority            = '10',
  $port                = '80',
  $selinux_context     = 'system_u:object_r:httpd_sys_content_t',
) {
  validate_re($source, '^git$|^package$')
  validate_re($git_proto, '^git$|^https$')
  validate_re($priority, '^\d+$')
  validate_re($port, '^\d+$')
  validate_bool($rhn)
  validate_hash($descriptions)

  if $mailto {
    validate_email_address($mailto)
  }
  if $mailfrom {
    validate_email_address($mailfrom)
  }

  if $rhn {
    validate_re($rhn_username, '.+')
    validate_re($rhn_password, '.+')
  }

}
