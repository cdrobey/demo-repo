# monitor
#
# Install and configure telegraf for system managment.
#
# @summary  This profiles deployes the telegraph agent for a consistent form of 
#           monitor systems.
#
# @param    influxdburi   - provides the location of the influxdb
#           influxdbname  - name of the db instance for storing data
#
# @example
#   include profile::os::monitor or assign in PE classifier
# == Class: profile::os::monitor
class profile::os::monitor (
  $influxdburi,
  $influxdbname,
  $influxdbinputs,
  Hash $inputs,
){
  if $trusted['extensions']['pp_environment'] == 'home' {
    class { 'telegraf':
      hostname => $facts['hostname'],
      outputs  => {
        'influxdb' => {
          'urls'     => [ $influxdburi, ],
          'database' => $influxdbname,
        }
      },
      inputs   => $influxdbinputs,
    }
  }
  $inputs.each | $input_name, $input_data | {
    telegraf::input { $input_name:
      plugin_type => $input_data['plugin_type'],
      options     => $input_data['options'],
  }
}
