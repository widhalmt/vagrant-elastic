class profile::logstash {

  include "java"

  package { "logstash":
    ensure  => 'installed',
    require => Package['java-1.8.0-openjdk'],
  }


#  exec { "create_logstash_service":
#    command => '/usr/share/logstash/bin/system-install',
#    require => Package['logstash'],
#    creates => '/etc/systemd/system/logstash.service',
#  }

  service { "logstash":
    ensure  => 'running',
    enable  => true,
#    require => Exec['create_logstash_service'],
    require => Package['logstash'],
  }

  file_line { "logstash_config_reload":
    path => '/etc/logstash/logstash.yml',
    line => 'config.reload.automatic: true',
    match => '^config.reload.automatic:',
    notify => Service['logstash'],
    require => Package['logstash'],
  }

  file_line { "logstash_api":
    path => '/etc/logstash/logstash.yml',
    line => 'http.host: "0.0.0.0"',
    match => '^http.host:',
    notify => Service['logstash'],
    require => Package['logstash'],
  }
  file_line { "logstash_pipelines":
    path => '/etc/logstash/logstash.yml',
    line => '#path.config: /etc/logstash/conf.d/*.conf',
    match => 'path.config',
    notify => Service['logstash'],
    require => Package['logstash'],
  }
  file_line { "logstash_monitoring_elasticsearch":
    path => '/etc/logstash/logstash.yml',
    line => 'xpack.monitoring.elasticsearch.url: ["http://logstash01:9200", "http://logstash02:9200"]',
    match => '^xpack.monitoring.elasticsearch.url:',
    notify => Service['logstash'],
    require => Package['logstash'],
  }
  file_line { "logstash_monitoring":
    path => '/etc/logstash/logstash.yml',
    line => 'xpack.monitoring.enabled: true',
    match => '^xpack.monitoring.enabled',
    notify => Service['logstash'],
    require => Package['logstash'],
  }
  file { "pipelines.yml":
    ensure => "file",
    notify => Service['logstash'],
    source => 'puppet:///modules/profile/pipelines.yml',
    path   => '/etc/logstash/pipelines.yml',
    mode => '0644',
    require => Package['logstash'],
  }
}
