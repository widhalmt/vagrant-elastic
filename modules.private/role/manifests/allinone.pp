class role::allinone {
  include 'profile::elasticsearch'
  include 'profile::logstash'
  include 'profile::kibana'
  include 'profile::filebeat'
  include 'profile::base'
  include 'profile::redis'
}
