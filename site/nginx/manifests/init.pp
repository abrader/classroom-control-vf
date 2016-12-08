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
    notify => Package['nginx'],    
    source => 'puppet:///modules/nginx/nginx.conf',
   }
   
  file { '/etc/nginx/conf.d/default.conf' :
    ensure => file,
    path   => '',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/nginx/default.conf',
    notify => Service['nginx'],
  }
  
  service { 'nginx' :
    ensure => running,
    enable => true,
  }
}
