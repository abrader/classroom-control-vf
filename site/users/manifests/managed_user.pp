define user::managed_user(
  $name = $title,
  $home,
) {

  user { $name:
    ensure => present,
    home   => $home,
  }

}
