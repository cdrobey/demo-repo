# == Class: profile::base::accounts
class profile::base::accounts {
  class { 'accounts':
    ssh_keys   => hiera_hash('accounts::ssh_keys', {}),
    users      => hiera_hash('accounts::users', {}),
    usergroups => hiera_hash('accounts::usergroups', {}),
  }
}
