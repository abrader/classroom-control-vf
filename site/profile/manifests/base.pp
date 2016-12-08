class profile::base {
  notify { "Hello, my name is ${::hostname}": }
  $msg => hiera('info','I am base.pp!')
  notify { "Hello again.. ${msg}": }
}
