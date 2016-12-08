class users::admins {
  users::managed_user { 'jose': home => '/home/jose' }
  users::managed_user { 'alice': }
  users::managed_user { 'chen': }
}
