class mrepo::repos (
  Hash $resources = {}
) {
  create_resources('mrepo::repo',$resources)

  Class['mrepo::selinux']
  -> Class['mrepo::repos']
  -> Anchor['mrepo::end']
}
