class { "mrepo::params":
  rhn           => true,
  rhn_username  => "test",
  rhn_password  => "test",
}

include mrepo::rhn
