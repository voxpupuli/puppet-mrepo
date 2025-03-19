# PRIVATE CLASS: do not call directly
#
# == Parameters
#
# Optional parameters can be found in the mrepo::params class
#
# == Examples
#
# This class does not need to be directly included.
#
# == Author
# https://github.com/PascalBourdier
#
class mrepo::service {
  include mrepo

  $source         = $mrepo::source
  $service_manage = $mrepo::service_manage
  $service_enable = $mrepo::service_enable

  if ( $source == 'package' ) and ( str2bool($service_manage) == true ) {
    service { 'mrepo':
      enable => $service_enable,
    }
  }
}
