# haproxy
#
# Use haproxy modules to setup a load balancer.
#
# @summary  This profiles installes a haproxy loadbalancer to provide connection management.
#           A list of applications and ports may be specified in hiera files.
#
# @param    apps - a hased list of application rc scripts mapped to setup a test environment on boot of 
#           server
#
# @example
#   include profile::haproxy or assign in PE classifier
# == Class: profile::apps::haproxy
class profile::apps::haproxy (
){
  include haproxy

  haproxy::listen { 'unifi':
    collect_exported => false,
    ipaddress        => '10.1.1.56',
    ports            => '80',
  }
  haproxy::balancermember { 'bm00':
    listening_service => 'unifi',
    server_names      => 'unifi.fr.lan',
    ipaddresses       => '127.0.0.1',
    ports             => '8443',
    options           => 'check',
  }
}
