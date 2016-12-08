 class nginx {
     package { 'nginx':
      ensure => present,
     }
     
     file { '/etc/nginx/nginx.conf':
       path =>'/etc/nginx/nginx.conf',
       source => 'puppet:///modules/nginx/nginx.conf',
       require => Package['nginx'],
     }
     
     file { '/etc/nginx/conf.d/default.conf':
       path =>'/etc/nginx/conf.d/default.conf',
       source => 'puppet:///modules/nginx/default.conf',
       require => Package['nginx'],
     }

     
     service {'nginx':
      ensure =>running,
      enable =>true,
      subscribe => File['/etc/nginx/nginx.conf'],
      subscribe => File['/etc/nginx/conf.d/default.conf']
     }
   }
