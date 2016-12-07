class nginx {
  package {'nginx':
    ensure => present
  }

  file {'docroot':
    ensure => directory,
    path   => '/var/www'
  }

  file {'index.html':
    ensure   => file,
    source   => 'puppet:///modules/nginx/index.html',
    path     => File['docroot']['path'],
    require  => File['docroot'],
  }

  file {'nginx.conf':
    ensure  => file,
    source  => 'puppet:///modules/nginx/nginx.conf',
    require => Package['nginx'],
    path    => '/etc/nginx/nginx.conf',
  }

  file {'server': 
    ensure => file,
    source => 'puppet:///modules/nginx/default.conf',
    path   => '/etc/nginx/conf.d/default.conf',
  }

  service {'nginx':
    enable   => true,
    ensure   => running,
    subcribe => [ File['nginx.conf'], File['server'] ],
  }
}
