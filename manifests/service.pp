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
class mrepo::service($service_enable = false) {

  include ::mrepo

  $source = $mrepo::source

  if ( $source == 'package' ) and ( $service_enable ) {
    service { 'mrepo':
      enable  => true,
    }
  }

}
