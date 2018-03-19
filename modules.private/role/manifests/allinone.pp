class role::allinone {
  include 'profile::elasticsearch'
  include 'profile::logstash'
  include 'profile::kibana'
  include 'profile::base'
  include 'profile::redis'
  include 'profile::filebeat'
  include 'profile::auditbeat'
  include 'profile::packetbeat'
  include 'profile::cerebro'
}
