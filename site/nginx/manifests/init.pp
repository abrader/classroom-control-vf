class nginx {
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }

  package { $module_name :
    ensure => present,
    before => [ File['nginx_conf'], File['default_conf'] ],
  }

  file { ['/var/www', '/etc/nginx/conf.d'] :
    ensure  => directory,
    require => Package[$module_name],
  }

  file { 'nginx_conf' :
    ensure  => file,
    path    => '/etc/nginx/nginx.conf',
    source  => 'puppet:///modules/nginx/nginx.conf',
  }

  file { 'default_conf' :
    ensure  => file,
    path    => '/etc/nginx/conf.d/default.conf',
    source  => 'puppet:///modules/nginx/default.conf',
  }

  file { 'index_page' :
    ensure => file,
    path   => '/var/www/index.html',
    source => 'puppet:///modules/nginx/index.html',
  }

  service { $module_name :
    ensure    => running,
    enable    => true,
    require   => Package[$module_name],
    subscribe => [ File['nginx_conf'], File['default_conf'] ],
  }
}
