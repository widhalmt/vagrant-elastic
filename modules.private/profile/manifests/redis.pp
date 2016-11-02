class profile::redis {
  package { "redis":
    ensure => 'installed',
  }
}
