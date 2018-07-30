class profile::elasticsearch {

  include java

  package { "elasticsearch":
    ensure => 'installed',
  }

  package { "elasticsearch-curator":
    ensure => 'installed',
  }

  service { "elasticsearch":
    ensure  => 'running',
    enable  => true,
    require => [
      Package['elasticsearch'],
      Package['java-1.8.0-openjdk'],
      Exec['set_max_map_count'],
    ],
  }

  file_line { "elasticsearch_external":
    ensure  => 'present',
    path    => '/etc/elasticsearch/elasticsearch.yml',
    line    => 'network.host: ["_local_","_site_"]',
    match   => '^network.host:',
    require => Package['elasticsearch'],
    notify  => Service['elasticsearch'],
  }

  file_line { "elasticsearch_discovery":
    ensure  => 'present',
    path    => '/etc/elasticsearch/elasticsearch.yml',
    line    => 'discovery.zen.ping.unicast.hosts: ["logstash01", "logstash02"]',
    match   => '^discovery.zen.ping.unicast.hosts:',
    require => Package['elasticsearch'],
    notify  => Service['elasticsearch'],
  }

  file_line { "elasticsearch_network":
    ensure  => 'present',
    path    => '/etc/elasticsearch/elasticsearch.yml',
    line    => "network.publish_host: $ipaddress",
    match   => '^network.publish_host:',
    require => Package['elasticsearch'],
    notify  => Service['elasticsearch'],
  }

  file_line { "vm_max_map_count":
    ensure => 'present',
    path => '/etc/sysctl.conf',
    line => 'vm.max_map_count=262144',
    match => '^vm.max_map_count',
  }

  file_line { "xpack.monitoring.collection.enabled":
    ensure  => 'present',
    path    => '/etc/elasticsearch/elasticsearch.yml',
    line    => 'xpack.monitoring.collection.enabled: true',
    match   => '^xpack.monitoring.collection.enabled',
    require => Package['elasticsearch'],
    notify  => Service['elasticsearch'],
  }


  exec { "set_max_map_count":
    command => 'echo 262144 > /proc/sys/vm/max_map_count',
    path    => '/bin',
    unless  => 'cat /proc/sys/vm/max_map_count | grep 262144',
  }
}
