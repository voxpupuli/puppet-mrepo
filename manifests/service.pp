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
class mrepo::service(
  $service_enable = $mrepo::params::service_enable,
  $service_manage = $mrepo::params::service_manage,
) inherits ::mrepo::params {

  include ::mrepo

  $source = $mrepo::source

  if ( $source == 'package' ) and ( str2bool($service_manage) == true ) {
    service { 'mrepo':
      enable  => $service_enable,
    }
  }

}
