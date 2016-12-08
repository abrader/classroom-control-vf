class profile::base {
  $message = hiera('message')
  notify { "Here is my message: ${message}" : }
}
