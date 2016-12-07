class memcached {
  package { 'memcached':
    ensure => present,
  }

  file { 'memcached_conf':
    path    => '/etc/sysconfig/memcached'
    ensure  => 'file',
    group   => '0',
    mode    => '0644',
    owner   => '0',
  }

  service { 'memcached':
    enable => true,
    ensure => running,
    subscribe => File['/etc/sysconfig/memcached'],
  }
}
