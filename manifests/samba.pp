class genericservice::samba( $manage_firewall = true ) {
  # Basic Samba module
  # Handles services, does not currently handle configs.

  genericservice::core {'genericservice_samba':
    service           => 'samba',
    systemServiceName => 'smb',
  }
  
  if $manage_firewall == true {
    include firewall-config::base

    firewall { '100 allow samba:445':
      state => ['NEW'],
      dport => '445',
      proto => 'tcp',
      action => accept,
    }
  }
}
        
