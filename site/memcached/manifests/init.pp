 class memcached {
     package { 'memcached':
      ensure => present,
     }
     file { '/etc/sysconfig/memcached':
     path =>'sysconfig/memcached',
     content =>'PORT="11211"\nUSER="memcached"\nMAXCONN="96"\nCACHESIZE="32"\nOPTIONS="\n'
     require => Package['memcached'],
     }
     service {'memcached':
      ensure =>running,
      enable =>true,
      subscribe => File['/etc/sysconfig/memcached']
     }
   }
      
