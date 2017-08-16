# Class: profile::master::nodemanager
class profile::master::nodemanager {

  # GENERAL PURPOSE
  # Node Groups ready to go out of the box. Not tied to any specific demo, but
  # potentially useful for demonstrating the Node Manager in general.

  node_group { 'PE Master':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'PE Infrastructure',
    rule                 => ['or', ['=', 'name', $::clientcert]],
    classes              => {
      'pe_repo'                                          => {},
      'pe_repo::platform::el_6_x86_64'                   => {},
      'pe_repo::platform::el_7_x86_64'                   => {},
      'pe_repo::platform::ubuntu_1404_amd64'             => {},
      'pe_repo::platform::windows_x86_64'                => {},
      'puppet_enterprise::profile::master'               => {
        'code_manager_auto_configure' => true,
        'r10k_remote'                 => 'https://github.com/cdrobey/puppet-repo.git',
        'r10k_private_key'            => '/etc/puppetlabs/puppetserver/ssh/id-control_repo.rsa' },
      'puppet_enterprise::profile::master::mcollective'  => {},
      'puppet_enterprise::profile::mcollective::peadmin' => {},
      'role::master'                                     => {},
    },
  }

  node_group { 'Linux':
    ensure               => present,
    environment          => 'production',
    override_environment => false,
    parent               => 'All Servers',
    rule                 => ['or', ['=', 'name', $::clientcert]],
    classes              => {
      'role::linux' => {},
    },
  }
}
