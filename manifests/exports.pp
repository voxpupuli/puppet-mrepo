# This class configures NFS exporting of mrepo repository data.
#
# == Examples
#
# class { 'mrepo::exports':
#   clients => '10.10.0.0/24',
# }
#
# == Author
#
# Adrien Thebo <adrien@puppetlabs.com>
#
# == Copyright
#
# Copyright 2012 Puppet Labs, unless otherwise noted
#
class mrepo::exports($clients) {
  include mrepo::params

  $file_path = '/usr/local/sbin/export-mrepo'

  file { $file_path:
    ensure => present,
    source => 'puppet:///modules/mrepo/export-mrepo',
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  if is_array($clients) {
    $clients_real = inline_template('<%= scope.lookupvar("clients").map {|c| "-c #{c}"}.join(" ") %>')
  }
  else {
    $clients_real = "-c ${clients}"
  }

  cron { "Export mrepo repositories":
    command => "${file_path} ${clients_real} write",
    ensure  => present,
    user    => 'root',
    minute  => fqdn_rand(60),
    require => File[$file_path],
  }
}
