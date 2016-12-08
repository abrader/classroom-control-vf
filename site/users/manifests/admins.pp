class users::admins {

  users::managed_user{ 'bert': }
  
  users::managed_user{ 'clown' :
    group => 'clowns',
  }
  
  group { 'clowns':
    ensure => present,
  }
}
