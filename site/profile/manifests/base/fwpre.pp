# == Class: profile::base::fwpre
class profile::base::fwpre {
  Firewall {
    require => undef,
  }
firewall { '000 accept all icmp':
  proto  => 'icmp',
  action => 'accept',
  }
firewall { '001 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  }
  firewall { '002 accept related established rules':
    proto  => 'all',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  }
  firewall { '101 allow http access':
    dport  => '80',
    proto  => tcp,
    action => accept,
  }
  firewall { '102 allow https access':
    dport  => '443',
    proto  => tcp,
    action => accept,
  }
  firewall { '103 allow PE access':
    dport  => '8140',
    proto  => tcp,
    action => accept,
  }
}
