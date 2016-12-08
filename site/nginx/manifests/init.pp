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
    #notify  => Service['memcached.service'],
  }

  service { 'nginx.service':
    ensure => 'running',
    enable => 'true',
    require => [Package['nginx'], File['/var/www/index.html']],
  }
}
