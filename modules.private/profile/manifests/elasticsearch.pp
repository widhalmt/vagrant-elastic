class profile::elasticsearch {

  include java

  package { "elasticsearch":
    ensure => 'installed',
  }

  service { "elasticsearch":
    ensure => 'running',
    enable => true,
    require => [
      Package['elasticsearch'],
      Package['java-1.8.0-openjdk'],
    ],
  }
}
