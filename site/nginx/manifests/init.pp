class nginx {
  case $::osfamily {
    'redhat','debiani' : {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'
    }
    'windows' : {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx/'
      $logdir  = 'C:/ProgramData/nginx/logs'
    }
    default : {
      fail("Module ${module_name} is not supported for use on ${::osfamily}")
    }
  }
  
  $user = $::osfamily ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }

  File {
    owner => $owner,
    group => $group,
    mode  => '0644',
  }

  package { $package :
    ensure => present,
    before => [ File['nginx_conf'], File['default_conf'] ],
  }

  file { [ $docroot, "${confdir}/conf.d" ] :
    ensure  => directory,
    require => Package[$package],
  }

  file { 'nginx_conf' :
    ensure   => file,
    path     => "${confdir}/nginx.conf",
    content  => epp('nginx/nginx.conf.epp',{
      user    => $user,
      confdir => $confdir,
      logdir  => $logdir,
    }),
  }

  file { 'default_conf' :
    ensure   => file,
    path     => "${confdir}/conf.d/default.conf",
    content  => epp('nginx/default.conf.epp', {
      docroot => $docroot,
    }),
  }

  file { 'index_page' :
    ensure => file,
    path   => '/var/www/index.html',
    source => 'puppet:///modules/nginx/index.html',
  }

  service { 'nginx' :
    ensure    => running,
    enable    => true,
    require   => Package[$module_name],
    subscribe => [ File['nginx_conf'], File['default_conf'] ],
  }
}
