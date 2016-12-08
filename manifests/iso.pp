# = mrepo::iso
#
# Downloads isos
define mrepo::iso($source_url, $repo) {

  include ::mrepo

  $target_file = "${mrepo::src_root}/iso/${name}"

  staging::file { $name:
    source => "${source_url}/${name}",
    target => $target_file,
    before => Mrepo::Repo[$repo],
  }
}
