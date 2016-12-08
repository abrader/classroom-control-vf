class profile::base {
  notify { "Hello, my name is ${::hostname}": }
  
  $hiera_message = hiera('message')
  notify { $hiera_message: }
}
