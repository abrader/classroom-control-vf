class nginx {
  package { 'nginx':
    ensure => present,
  }
  
  file { 'nginx_conf':
    source  => puppet:///modules/nginx/files/nginx.conf,
    owner   => 'root',
    group   => 'root',
    path    => '/etc/nginx/nginx.conf',
    mode    => '0644',
  }
  
  file { 'default_vhost':
    source  => puppet:///modules/nginx/files/default.conf,
    owner   => 'root',
    group   => 'root',
    path    => '/etc/nginx/conf/default.conf',
    mode    => '0644',
  }
  
  
