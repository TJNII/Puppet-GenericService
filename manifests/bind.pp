class genericservice::bind( $manage_firewall = true ) {
  # Basic BIND class
  # Installs and enables bind, does nto currently manage its config.

  genericservice::core { 'genericservice_bind':
    service => 'bind',
    systemServiceName => 'named',
  }

  if $manage_firewall == true {
    include firewall-config::base

    firewall { '100 allow TCP DNS':
      state => ['NEW'],
      dport => '53',
      proto => 'tcp',
      action => accept,
    }
  
    firewall { '100 allow UDP DNS':
      state => ['NEW'],
      dport => '53',
      proto => 'udp',
      action => accept,
    }
  }
}
                          
