class profile::base {
  $msg = hiera('message')
  notify { "Hello, my name is ${::hostname}": }
  notify { "Hello, hiera message ${msg}": }
}
