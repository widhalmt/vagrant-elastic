# Elastic Stack Test Environment #

Use the following to get a running instance of the Elastic Stack:

    r10k puppetfile install
    vagrant up --provision

This is an early version of the test setup and needs more work. 

Most of the vagrant and puppet magic was inspired by the [Vagrant boxes](https://github.com/lbetz/vagrant-icinga-book) for the [Icinga 2 book](http://amzn.to/2edrU6F).

## Disclaimer / Purpose ##

This is by **no means** a best-practice production setup.

This environment was built for:

* Having a test environment while updateing the slides for the Netways [Elastic Stack Training](https://www.netways.de/produkte/elastic_stack/). This is not used during the trainings because installation and configuration is part of them.
* Having a dev / test environment for the [check_logstash](https://github.com/widhalmt/check_logstash) monitoring plugin.
* Having an easy to use environment during support sessions
* Giving other users a quick and easy way to try Elastic Stack 5

Maybe this project will mature into a best-practice showcase if people are interested.

The Puppet code is not as nice as it could be. e.g. there is heavy usage of `file_line` instead of templates. This is due to the fact that it should show what has to be changed from a default installation to get a working setup and maybe later get a best-practice setup.

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
