# == Class: profile::base::sudoers
class profile::base::sudoers (
  $purge,
  $config_file_replace,
  $includedirsudoers,
  $configs,
) {

  class { 'sudo':
    purge               => $purge,
    config_file_replace => $config_file_replace,
    includedirsudoers   => $includedirsudoers,
  }
#  create_resources(sudo::conf, $configs)
  each ($configs) | $name, $configs | {
    sudo::conf { $name:
      * => $configs
    }
  }
}
