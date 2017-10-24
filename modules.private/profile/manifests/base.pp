class profile::base {

  stage { 'first': } -> stage { 'repos': } -> Stage['main']

  package { 'vim-enhanced':
    ensure => 'installed',
  }

  package { 'ntp':
    ensure => 'installed',
  }

  service { 'ntpd':
    ensure => 'running',
    enable => true,
    require => Package['ntp'],
  }

  service { 'firewalld':
    ensure => 'stopped',
    enable => false,
  }

  host { 'logstash01':
    ensure => 'present',
    ip     => '192.168.5.10',
  }
  host { 'logstash02':
    ensure => 'present',
    ip     => '192.168.5.20',
  }

  class { 'repos::elastic':
    stage => 'repos',
  }

  class { 'repos::curator':
    stage => 'repos',
  }

  file_line { "selinux-permissive":
    ensure  => 'present',
    path    => '/etc/sysconfig/selinux',
    line    => 'SELINUX=permissive',
    match   => '^SELINUX=',
  }


}
