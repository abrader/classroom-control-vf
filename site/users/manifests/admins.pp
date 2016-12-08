class users::admins {

  user::managed_user { 'joe' : }
  
  user::managed_user { 'alice' :
    group => 'staff',
  }
  
  group { 'staff' :
    ensure => present,
  }

}
