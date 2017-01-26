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
class mrepo::params
{

  $src_root            = '/var/mrepo'
  $www_root            = '/var/www/mrepo'
  $www_servername      = 'mrepo'
  $www_ip              = $::ipaddress
  $www_ip_based        = false
  $user                = 'apache'
  $group               = 'apache'
  $source              = 'package'
  $ensure_src          = 'latest'
  $selinux             = undef
  $rhn                 = false
  $rhn_config          = false
  $rhn_username        = ''
  $rhn_password        = ''
  $rhnget_cleanup      = undef
  $rhnget_download_all = undef
  $genid_command       = '/usr/bin/gensystemid'
  $mailto              = undef
  $mailfrom            = undef
  $smtpserver          = undef
  $git_proto           = 'git'
  $descriptions        = {}
  $http_proxy          = ''
  $https_proxy         = ''
  $priority            = '10'
  $port                = '80'
  $selinux_context     = 'system_u:object_r:httpd_sys_content_t'
  $service_enable      = true
  $service_manage      = false

}
