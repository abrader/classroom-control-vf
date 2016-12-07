class memcached { 

  package { 'memcached' :
  ensure => present,
  }
  
  file { 'file-memcached' :
    ensure => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => '#managed by Puppet\
    PORT="11211"\
    USER="memcached"\
    MAXCONN="96"\
    CACHESIZE="32"\
    OPTIONS=""',
    require => Package['memcached'],
  }
  
  service { 'memcached' :
    ensure => running,
    enable => true,
    subscribe => File['file-memcached'],  
  }
}
