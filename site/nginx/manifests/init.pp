class nginx{
  package { 'nginx' :
    ensure => present,
  }
 
  file { '/var/www' :
    ensure => directory,  
  }

 file { '/etc/nginx/nginx.conf' :
     ensure => file,
     owner   => 'root',
     group   => 'root',
     mode    => '0644',     
     require => Package['nginx'], 
     notify => Package['nginx'],    
     source => 'puppet:///modules/nginx/nginx.conf',
  }
    
  file { '/etc/nginx/conf.d/default.conf' :
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/default.conf',
    require => Package['nginx'], 
    notify => Service['nginx'],
  }
  
  file { '/var/www/index.html' :
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/index.html',
  }
  service { 'nginx' :
    ensure => running,
    enable => true,
  }
}
