class skeleton {

  file {'skel_dir' :
    ensure => directory,
    path => '/etc/skel',
    owner => 'root',
    group => 'root',
    mode => '0755',
  }
  
  file {'/etc/skel/.bashrc' :
    ensure => file,
    owner => 'root',
    group => 'root',
    mode => '0644',
    source => 'puppet:///modules/skeleton/bashrc',    
  }
  
  
}
