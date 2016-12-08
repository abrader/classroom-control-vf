class nginx (
  $package = $nginx::params::package,
  $owner   = $nginx::params::owner,
  $group   = $nginx::params::group,
  $docroot = $nginx::params::docroot,
  $confdir = $nginx::params::confdir,
  $logdir  = $nginx::params::logdir,
  $user    = $nginx::params::user,
  $port    = $nginx::params::port,
) inherits nginx::params {

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
    ensure    => file,
    path      => "${confdir}/nginx.conf",
    content   => epp('nginx/nginx.conf.epp',{
      user    => $user,
      confdir => $confdir,
      logdir  => $logdir,
    }),
  }

  file { 'default_conf' :
    ensure    => file,
    path      => "${confdir}/conf.d/default.conf",
    content   => epp('nginx/default.conf.epp', {
      docroot => $docroot,
      port    => $port,
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
