class nginx(
  $port = 80
){
  package { 'nginx':
    ensure => present
  }
  
  File {
    owner => 'root',
    group => 'root',
    mode  => '0644',
  }
 
  file { '/var/www/':
    ensure => 'directory',
    require => Package['nginx'],
  }

 
  file { '/var/www/index.html':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => 'file',
    content => epp('nginx/nginx.conf.epp', { nginx_user => 'nginx' }),
    notify  => Service['nginx.service'],
    require => Package['nginx'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure  => 'present',
    source  => epp('nginx/default.conf.epp', { nginx_port => $port }),
    notify  => Service['nginx.service'],
    require => Package['nginx'],
  }

  service { 'nginx.service':
    ensure => 'running',
    enable => 'true',
    require => [Package['nginx'], File['/var/www/index.html'], File['/etc/nginx/conf.d/default.conf'], File['/etc/nginx/nginx.conf']],
  }
}
