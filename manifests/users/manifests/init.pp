  class users {
    user { 'fundamentals':
      ensure   => present,
      shell    => '/bin/bash',
    }
  }
