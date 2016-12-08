class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package { 'nginx' :
    ensure => present,
  }

  file { 'conf_d_dir' :
    ensure  => directory,
    path    => '/etc/nginx/conf.d/',
    require => Package['nginx'],
  }

  file { 'nginx_conf' :
    ensure  => file,
    path    => '/etc/nginx/nginx.conf',
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { 'default_conf' :
    ensure  => file,
    path    => '/etc/nginx/conf.d/default.conf',
    source  => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  file { 'docroot' :
    ensure => directory,
    path   => '/var/www',
  }

  file { 'index_page' :
    ensure => file,
    path   => '/var/www/index.html',
    source => 'puppet:///modules/nginx/index.html',
  }

  service { 'nginx' :
    ensure => running,
    enable => true,
  }
}
