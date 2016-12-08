define users::managed_user(
  $home = undef,
) {

  user { $title:
    ensure => present,
    home   => $home,
  }

}
