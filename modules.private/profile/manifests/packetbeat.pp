class profile::packetbeat {

  package { "packetbeat":
    ensure => 'installed',
  }
  service { "packetbeat":
    ensure  => 'running',
    enable  => true,
    require => Package['packetbeat'],
  }

  file { "packetbeat.yml":
    ensure => "file",
    notify => Service['packetbeat'],
    source => 'puppet:///modules/profile/packetbeat.yml',
    require => Package['packetbeat'],
    path   => '/etc/packetbeat/packetbeat.yml',
    mode => '0640',
  }
}
