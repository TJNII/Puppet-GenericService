define genericservice::core(
  $service,
  $packageName = undef,
  $systemServiceName = undef,
  ) {
    # Generic service handler
    # Handles service package and init, does not handle configs.
    # Does not handle the firewall.

    if $packageName == undef {
      $intPackageName = $service
    } else {
      $intPackageName = $packageName
    }

    if $systemServiceName == undef {
      $intServiceName = $service
    } else {
      $intServiceName = $systemServiceName
    }
    
    package { "$service":
      name => "$intPackageName",
      ensure => installed,
    }
    
    service { "$service":
      name      => $intServiceName,
      ensure    => running,
      enable    => true,
    }
  }
        
