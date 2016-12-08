define user::managed_user(
  $home,
) {

  user { $title:
    ensure => present,
    home   => $home,
  }

}
