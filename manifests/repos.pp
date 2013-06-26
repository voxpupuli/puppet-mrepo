class mrepo::repos (
  $resources = {}
) {
  validate_hash( $resources )
  create_resources('mrepo::repo',$resources)
}
