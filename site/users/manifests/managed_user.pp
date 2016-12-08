define users::managed_user(
  $home,
) {

  user { $title:
    ensure => present,
    home   => $home,
  }

}
