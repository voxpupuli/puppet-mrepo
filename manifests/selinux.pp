# This class configures selinux contexts for serving mrepo mirror data
# with apache. It corrects the SELinux context of mrepo mirror data to ensure
# that the web server can access mirror files.
#
# == Parameters
#
# Optional parameters can be found in the mrepo::params class
#
# == Examples
#
# This class does not need to be directly included
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2011 Puppet Labs, unless otherwise noted
#
class mrepo::selinux {
  include mrepo::params
  $src_root = $mrepo::params::src_root
  $www_root = $mrepo::params::www_root

  $context = "system_u:object_r:httpd_sys_content_t"

  if $use_selinux {
    exec { "Apply httpd context to mrepo $src_root":
      command   => "chcon -hR $context $src_root",
      path      => [ "/usr/bin", "/bin" ],
      user      => "root",
      group     => "root",
      unless    => "test `ls -dZ $src_root | awk '{print \$4}'` = '$context'",
      require   => File[$src_root],
      logoutput => on_failure,
    }

    exec { "Apply httpd context to mrepo $www_root":
      command   => "chcon -hR $context $www_root",
      path      => [ "/usr/bin", "/bin" ],
      user      => "root",
      group     => "root",
      unless    => "test `ls -dZ $www_root | awk '{print \$4}'` = '$context'",
      require   => File[$www_root],
      logoutput => on_failure,
    }
  }
}
