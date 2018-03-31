# network
#
# Install and configure base network profile.
#
# @summary  This profile configures the network service on a linux client.  Using parameters from hiera
#           the modules configures the network interfaces.
#
# @param    interfaces - provides the network intfaces to confirgure
#           network_servers - hased list of network servers used for network settings
#
# @example
#   include profile::base::linux::network or assign in PE classifier
# == Class: profile::base::linux::network
class profile::base::linux::network (
  Hash $interfaces,
  Array $nameservers,
  Array $searchpath,
  String $hostname,
  String $ip,
) {
  class { 'hostname':
    hostname => $hostname,
    ip       => $ip,
  }
  class { 'network':
    interfaces_hash => $interfaces,
  }
  if $facts['os']['family'] == 'Debian'{
    package { 'resolvconf':
      ensure => absent,
      name   => 'resolvconf',
    }
  }

  class { 'resolv_conf':
      nameservers => $nameservers,
      searchpath  => $searchpath,
  }
}
