class profile::auditbeat {

  package { "auditbeat":
    ensure => 'installed',
  }
  service { "auditbeat":
    ensure  => 'running',
    enable  => true,
    require => Package['auditbeat'],
  }

  file { "auditbeat.yml":
    ensure => "file",
    notify => Service['auditbeat'],
    require => Package['auditbeat'],
    source => 'puppet:///modules/profile/auditbeat.yml',
    path   => '/etc/auditbeat/auditbeat.yml',
    mode => '0640',
  }
}
