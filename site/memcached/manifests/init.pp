package { 'memcached':
  ensure => present,
}

file { 'memcached_conf':
  path    => '/etc/sysconfig/memcached'
  ensure  => 'file',
  content => '{md5}a79f5d50f8632f06682af7269bdd0505',
  group   => '0',
  mode    => '0644',
  owner   => '0',
}

service { 'memcached':
  enable => true,
  ensure => running,
  subscribe => File['/etc/sysconfig/memcached'],
}

