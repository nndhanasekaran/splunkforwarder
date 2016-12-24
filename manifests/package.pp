class splunkuf::package (
  $targeturi      = 'splunk-ds.tivo.com:8089',
  $mgmthostport   = undef,
  $rpmsrc         = 'http://spacewalk.tivo.com/repos/tivo/splunk/splunkforwarder-latest.rpm',
  $splunk_home    = $splunkuf::user::splunk_home,
  $system_user    = 'splunk',
  $splunk_home    = '/home/splunk',
  $package_ensure = 'installed',
  ) inherits splunkuf::params {


  case $systemd {
    true: {
      file { '/usr/lib/systemd/system/splunkforwarder.service':
        owner    => 'root',
        group    => 'root',
        mode     => '0755',
        content  => template('splunkuf/splunkforwarder.service.erb'),
        require  => Package[ 'splunkforwarder' ],
      }
    }
    default: {
      file { '/etc/init.d/splunk':
        owner    => 'root',
        group    => 'root',
        mode     => '0755',
        require  => Package[ 'splunkforwarder' ],
        content  => template('splunkuf/splunkforwarder.erb'),
      }
    }
  }
  
  user { 'splunk':
    ensure      => 'present',
    managehome  => true,
    home        => "$splunk_home",
  }

  package { 'splunkforwarder':
    ensure      => "$package_ensure",
    provider    => 'rpm',
    install_options => [ "--prefix=$splunk_home" ],
    source      => "$rpmsrc",
    require     => User['splunk'],
  }->
  file { '/opt/splunkforwarder':
    ensure      => link,
    target      => "$splunk_home/splunkforwarder",
    require     => Package['splunkforwarder'],
  }->
  file_line { 'splunk_bindip' :
      path       => "$splunk_home/splunkforwarder/etc/splunk-launch.conf",
      line       => 'SPLUNK_BINDIP=127.0.0.1',
      ensure     => 'present',
      require    => File['/opt/splunkforwarder'],
      notify     => Service['splunk'],
    }

  file { "$splunk_home/splunkforwarder/etc/system/local/deploymentclient.conf":
    owner       => $system_user,
    group       => $system_user,
    mode        => '0644',
    content     => template('splunkuf/deploymentclient.conf.erb'),
    notify      => Service['splunk'],
    require     => File['/opt/splunkforwarder'],
  }

  exec { 'change_default_pwd' :
    command      => '/opt/splunkforwarder/bin/splunk edit user admin -password "0EMyS9k&9Om74d" -role admin -auth admin:changeme --no-prompt --answer-yes',
    subscribe    => File[ '/opt/splunkforwarder' ],
    refreshonly  => true,
  }

  if $mgmthostport != undef {
    file { '/opt/splunkforwarder/etc/system/local/web.conf':
      owner      => $system_user,
      group      => $system_user,
      mode       => '0644',
      content    => template('splunkuf/web.conf.erb'),
      notify     => Service['splunk'],
      require    => Package['splunkforwarder'],
    }
  }
  contain splunkuf::service
} 
