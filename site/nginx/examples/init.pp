if $::osfamily == 'windows' {
  Package {
    provider => chocolatey,
  }
}

include nginx
