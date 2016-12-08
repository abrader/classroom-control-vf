class users::admins {

  user::managed_user{ 'bert': }
  
  user::managed_user{ 'clown' :
    group => 'clowns',
  }
  
  group { 'clowns':
    ensure => present,
  }
}
