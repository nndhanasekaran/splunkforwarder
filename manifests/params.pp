class splunkuf::params (
  $targeturi      = $splunkuf::package::targeturi,
  $system_user    = $splunkuf::package::system_user,
  $mgmthostport   = $splunkuf::package::mgmthostport,
  $rpmsrc         = $splunkuf::package::rpmsrc,
  $splunk_home    = $splunkuf::package::splunk_home,
  $package_esnure = $splunkuf::package::package_ensure,
  $service_ensure = $splunkuf::service::service_ensure,
  $service_enable = $splunkuf::service::service_enable,
) {
  case $::osfamily {
    'RedHat': {
      if $::operatingsystemmajrelease >= 7 {
        $systemd = true
      }
    }
    'Debian': {
      if $::operatingsystemmajrelease >= 8 {
        $systemd = true
      }
    }
    'Ubuntu': {
      if $::operatingsystemmajrelease >= 15 {
        $systemd = true
      }
    }
    default: {
      $systemd = false
    }
  }
}
