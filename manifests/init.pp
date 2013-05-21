class genericservice(
  $service,
  $packageName = undef,
  $systemServiceName = undef,
  ) {
    # Generic service handler
    # Handles service package and init, does not handle configs.
    # Does not handle the firewall.
    genericservice::core { "genericservice_$service":
      service           => $service,
      packageName       => $packageName,
      systemServiceName => $systemServiceName,
    }
  }
