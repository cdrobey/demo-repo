# app
#
# Install and configure base app profile.
#
# @summary  This profile configures the chocolatey provider and installs a list of appliations.  Using 
#           parameters from hiera the list of packages is installed an performs a reboot when necessary.
#           A standard set of fixed packages including dotnet 4.5 and powershell are updated to ensure 
#           chocolatey support.
#
# @param    packages - hashed list of packages install
#
# @example
#   include profile::base::windows::app or assign in PE classifier
# == Class: profile::base::windows::app
class profile::base::windows::app (
  $packages,
) {
  include chocolatey

  Package {
    ensure => latest,
    provider => chocolatey,
  }
  # Static packages with Reboot
  reboot { 'package_reboot':
    when => 'pending',
  }
  package { 'dotnet4.5':
    notify => Reboot['package_reboot']
  }
  package { 'powershell':
    notify => [
      Reboot['package_reboot'],
      Service['WinRM'],
    ],
  }
  service { 'WinRM':
    ensure    => 'running',
    enable    => true,
    subscribe => Package['powershell']
  }
  # Dynamic installed packages (Defined in Heira)
  each ($packages) | $package | {
    package { $package: }
  }
}
