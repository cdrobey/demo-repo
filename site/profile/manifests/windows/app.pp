# == Class: profile::windows::app
class profile::windows::app (
  $version,
  $reboot,
  $packages,
) {
  include chocolatey

  Package { provider => chocolatey, }

  package { '7zip':
    ensure => present,
  }
  #each ($packages) | $name, $package | {
  #  package { $name:
  #    ensure => $package['ensure'],
  #  }
  #}
}
