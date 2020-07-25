# Class: mrepo::iso
#
# This define downloads iso files
#
# @param title Specifies the filename of the ISO file
# @param source_url Specifies the URL portion to the path where the above ISO
#  file is actually found. This parameter gets concatenated with the filename
#  from title param, which then forms the whole URL to the ISO file.
# @param repo Title of the mrepo::repo resources the ISO file belongs to
define mrepo::iso ($source_url, $repo) {
  include mrepo

  $target_file = "${mrepo::src_root}/iso/${name}"

  ensure_resource('file', "${mrepo::src_root}/iso", {
      'ensure' => 'directory',
      'owner'  => $mrepo::user,
      'group'  => $mrepo::group,
      'mode'   => '0644',
  })

  archive { $target_file:
    source  => "${source_url}/${name}",
    before  => Mrepo::Repo[$repo],
    require => File["${mrepo::src_root}/iso"],
  }
}
