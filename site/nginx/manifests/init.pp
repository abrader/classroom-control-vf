class nginx {
  package { 'nginx':
    ensure => present
  }
 
  file { '/var/www/':
    ensure => 'directory',
    group  => 'root',
    mode   => '0755',
    owner  => 'root',
    require => Package['nginx'],
  }

 
  file { '/var/www/index.html':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/index.html',
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure  => 'file',
    source  => 'puppet:///modules/nginx/nginx.conf',
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    notify  => Service['nginx.service'],
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure  => 'present',
    source  => 'puppet:///modules/nginx/default.conf',
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
    notify  => Service['nginx.service'],
  }

  service { 'nginx.service':
    ensure => 'running',
    enable => 'true',
    require => [Package['nginx'], File['/var/www/index.html']],
  }
}
