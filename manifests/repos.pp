class mrepo::repos (
  $repo_hash = {}
) {
  validate_hash( $repo_hash )
  create_resources('mrepo::repo',$repo_hash)
}
