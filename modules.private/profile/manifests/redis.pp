class profile::redis {
  package { "redis":
    ensure => 'installed',
  }
  service { "redis":
    ensure => 'running',
    enable => 'true',
    require => Package["redis"],
  }
}
