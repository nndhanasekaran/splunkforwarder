class splunkuf::user (
  $splunk_home  = '/home/splunk',
) inherits splunkuf::params {
  user { 'splunk':
    ensure      => 'present',
    managehome  => true,
    home        => "$splunk_home",
  }
}
