class nginx {
  package { 'nginx' :
    ensure => present,
  }

  file { 'nginx_conf' :
    ensure => file,
    path   => '/etc/nginx/nginx.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/nginx.conf',
    notify => Service['nginx'],
  }

  file { 'default_conf' :
    ensure => file,
    path   => '/etc/nginx/conf.d/default.conf',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/default.conf',
    notify => Service['nginx'],
  }

  file { 'index_page' :
    ensure => file,
    path   => '/var/www/index.html',
    mode   => '0644',
    source => 'puppet:///modules/nginx/index.html',
  }

  service { 'nginx' :
    ensure => running,
    enable => true,
  }
}
