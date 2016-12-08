define users::managed_user (
  $user_name  = $title,
  $home  = "/home/${title}",
  $user_group = $title,
) {
  user { $user_name :
    ensure     => present,
    home       => $home,
    gid        => $user_group,
    managehome => true
  }

  group { $user_group :
    ensure => present
  }

  file { "/home/${title}/.ssh":
   ensure => directory,
   owner  => $user_name,
  }
}
