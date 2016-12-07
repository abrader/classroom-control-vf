class memcached {
  package { 'memcached' :
    ensure => present,
  }
  
  file { 'sysconfig_memcached' :
    ensure  => file,
    path    => '/etc/sysconfig/memcached',
    source  => 'puppet:///modules/memcached/memcached',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['memcached'],
  }
  
  service { 'memcached' :
    ensure => running,
    enable => true,
    subscribe => File['sysconfig_memcached'],
  }
}
