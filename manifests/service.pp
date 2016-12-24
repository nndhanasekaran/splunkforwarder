class splunkuf::service (
  $service_ensure = 'running',
  $service_enable = true,
) inherits splunkuf::params {  
  service { 'splunk':
    ensure       => "$service_ensure",
    enable       => "$service_enable",
  }
}
