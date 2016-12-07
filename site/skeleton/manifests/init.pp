class skeleton {
  file { '/etc/skel':
    ensure => 'directory',
    group  => 'root',
    mode   => '0755',
    owner  => 'root',
  }

  file { '/etc/skel/.bashrc':
    ensure  => 'file',
    content => 'puppet:///modules/skel/.bashrc',
    group   => 'root',
    mode    => '0644',
    owner   => 'root',
  }

}
