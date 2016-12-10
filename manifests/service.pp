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

  include ::mrepo::params

  $source = $mrepo::params::source

  if $source == 'package' {
    service { 'mrepo':
      require => [Package['mrepo']],
      enable  => true,
    }
  }

}
