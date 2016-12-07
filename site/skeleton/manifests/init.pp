class 'skeleton' {
  file { 'skel_dir' :
    ensure => 'directory',
    path   => '/etc/skel',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

  file { 'skel_bashrc' :
    ensure => 'file',
    path   => '/etc/skel/.bashrc',
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/skeleton/bashrc',
  }
}
