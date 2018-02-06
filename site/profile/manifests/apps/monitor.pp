# monitor
#
# Monitoring platform for reviewing Ubuntu/Centos/Windows VMs
#
# @summary  This module build a monitoring plaform using InfluxDB and Grafana.  I recommend running Telegraph
#           on local system for data ingest.
#
# @param    none
#
# @example
#   include profile::monitor or assign in PE classifier
# == Class: profile::apps::monitor
class profile::apps::monitor (
){
    firewall { '300 allow communication to InfluxDB and Grafana':
        dport  => [8086, 8083, 3000],
        proto  => tcp,
        action =>  accept,
    }

    class {'influxdb':
        ensure         => 'present',
        manage_repos   => true,
        manage_service => true,
        version        => '1.4.2-1',
    }

    -> class { 'grafana':
    }
    -> grafana_datasource { 'influxdb':
        grafana_url      => 'http://localhost:3000',
        grafana_user     => 'admin',
        grafana_password => 'admin',
        type             => 'influxdb',
        url              => 'http://localhost:8086',
        database         => 'Monitor',
        access_mode      => 'proxy',
        is_default       => true,
    }

    class { 'telegraf':
        hostname => $facts['hostname'],
        outputs  => {
            'influxdb' => {
                'urls'     => [ 'http://monitor:8086', ],
                'database' => 'Monitor',
                'username' => 'monitor',
                'password' => 'monitor',
            }
        },
        inputs   => {
            'cpu'    => {},
            'mem'    => {},
            'io'     => {},
            'net'    => {},
            'disk'   => {},
            'swap'   => {},
            'system' => {},
        }
    }
}
