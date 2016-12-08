class profile::base {
  notify { "Hello, my name is ${::hostname}": }
  #$msg => hiera('info','I am base.pp!')
  
  #notify { hiera('message', 'I am base.pp!'): }
  #notify { "Hello again.. ${msg}": }
  
  $message = hiera('message')
  notify { "Here is my message: ${message}" : }
}
