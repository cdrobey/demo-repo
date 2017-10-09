# == Class: profile::master
class profile::master
{
  firewall { '200 allow unifi access':
    dport  => [80, 443, 8140],
    proto  => tcp,
    action =>  accept,
  }
  service { 'firewalld':
    ensure =>  stopped,
  }
  include profile::master::hiera
}
