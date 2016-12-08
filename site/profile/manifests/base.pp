class profile::base {
  notify { "Hello, my name is ${::hostname}": }
  server => hiera('info','I am base.pp!')
  notify { "Hello again.. ${info}": }
}
