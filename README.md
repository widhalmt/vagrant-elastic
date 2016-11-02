# Elastic Stack Test Environment #

Use the following to get a running instance of the Elastic Stack:

    r10k puppetfile install
    vagrant up --provision

This is an early version of the test setup and needs more work. 

Most of the vagrant and puppet magic was inspired by the [Vagrant boxes](https://github.com/lbetz/vagrant-icinga-book) for the [Icinga 2 book](http://amzn.to/2edrU6F).

## Usage ##

### Single node tests ###

You can run a single instance by issueing the following command:

    vagrant up elastic01 --provision

This capability is the main reason why some cluster tweaks in `elasticsearch.yml` are missing.

### Logstash configuration ###

You can change the configuration in the `logstash-indexer` directory. This directory is mounted into the boxes and Logstash will automatically reload new configuration after changes.

## Connecting ##

You can use `vagrant ssh elastic01` to log in to the main node.

The following ports are forwarded and you can use them for connecting via localhost.

* 5601 : kibana on elastic01
* 9200 : REST API of Elasticsearch on elastic01
* 9600 : REAST node API of Logstash on elastic01
