# Elastic Stack Test Environment #

Use the following to get a running instance of the Elastic Stack:

    r10k puppetfile install
    vagrant up --provision

This is an early version of the test setup and needs more work. For example this uses just a single host and does not provide an Elasticsearch cluster.

Most of the vagrant and puppet magic was inspired by the [Vagrant boxes](https://github.com/lbetz/vagrant-icinga-book) for the [Icinga 2 book](http://amzn.to/2edrU6F).
