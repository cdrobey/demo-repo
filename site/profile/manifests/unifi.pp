# == Class: profile::docker
class profile::unifi (
  $repo_release,
){
  firewall { '200 allow unifi access':
    dport  => [80, 443, 8080, 8443, 8843, 8880, 3478, 6789, 10001],
    proto  => tcp,
    action =>  accept,
  }

  class { 'unifi':
    repo_release => $repo_release,
  }

}
