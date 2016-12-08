class profile::base {
  $msg = hiera('message')
  notify { $msg: }
}
