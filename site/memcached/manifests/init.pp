class memcached {
  package { 'memcached':
    ensure => present,
    before => File['/etc/sysconfig/memcached'],
  }
  
  file { '/etc/sysconfig/memcached':
    ensure  => 'file',
    source  => 'puppet:///modules/memcached/memcached',
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    notify  => Service['memcached.service'],
  }
 
  service { 'memcached.service':
    ensure => 'running',
    enable => 'true',
    require => [Package['memcached'], File['/etc/sysconfig/memcached']],
  }
}
