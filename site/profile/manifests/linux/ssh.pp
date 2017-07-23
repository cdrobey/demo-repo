# == Class: profile::linux::ssh
class profile::linux::ssh (
  $password_authentication,
  $permit_root_login,
  $permit_empty_passwords,
  $manage_firewall,
  $banner,
) {

  class { 'ssh':
    sshd_password_authentication     => $password_authentication,
    permit_root_login                => $permit_root_login,
    sshd_config_permitemptypasswords => $permit_empty_passwords,
    manage_firewall                  => $manage_firewall,
    sshd_config_banner               => $banner,
  }
}
