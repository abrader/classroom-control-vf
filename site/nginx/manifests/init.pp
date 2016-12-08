class nginx (
  $package = nginx::params::package,
  $owner = nginx::params::owner,
  $group = nginx::params::group,
  $docroot = nginx::params::docroot,
  $confdir = nginx::params::confdir,
  $logdir = nginx::params::logdir,
  $user = nginx::params::user,
  $port = nginx::params::port,
) inherits nginx::params {
  package {'nginx':
    ensure => present
  }

  File {
    mode  => '0644',
    owner => 'root',
    group => 'root'
  }

  file {'/etc/nginx/conf.d':
    ensure => directory
  }

  file {'docroot':
    ensure => directory,
    path   => '/var/www'
  }

  file {'index.html':
    ensure   => file,
    source   => 'puppet:///modules/nginx/index.html',
    path     => '/var/www/index.html'
  }

  file {'nginx.conf':
    ensure  => file,
    content  => epp('nginx/nginx.conf.epp'),
    require => Package['nginx'],
    path    => '/etc/nginx/nginx.conf',
  }

  file {'server':
    ensure  => file,
    content => epp('nginx/default.conf.epp', {port => $port}),
    path    => '/etc/nginx/conf.d/default.conf',
  }

  service {'nginx':
    enable   => true,
    ensure   => running,
    subscribe => [ File['nginx.conf'], File['server'] ],
  }

  if $::is_virtual {
    $vm_name = capitalize($::virtual)
    notify {"Running in a VM of type ${vm_name}.": }
  }
}
