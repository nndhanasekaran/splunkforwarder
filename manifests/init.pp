# Class: splunkuf
class splunkuf inherits splunkuf::params {

  contain splunkuf::package
  contain splunkuf::service
  
}

