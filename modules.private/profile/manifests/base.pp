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

  class { 'repos::elastic':
    stage => 'repos',
  }


}
