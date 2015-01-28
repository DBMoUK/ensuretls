# ensuretls

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with ensuretls](#setup)
    * [What ensuretls affects](#what-ensuretls-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ensuretls](#beginning-with-ensuretls)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module secures encrypted communication between Puppet Master and Agents to be TLSv1.

## Module Description

This module should be classified against Puppet Master nodes only.  The module sshould not be installed on Puppet Agent nodes.

## Setup

Puppet Master CA node may be classified with profile: profile::ensuretls::console

PuppetDB Node may be classified with profile: profile::ensuretls::db

After classification, the node appropriate service is notified of the changes: pe-httpd on the CA node, and pe-puppetdb on the DB node.  
 
### What ensuretls::console affects

The module affects the following files in: /etc/puppetlabs/httpd/conf.d

ssl.conf
puppetdashboard.conf
puppetproxy.conf

The SSLProtocol configuration directive is changed to TLSv1, following classification of a Puppet Master node with the ensuretls::console profile.

### What ensuretls::db affects

/etc/puppetlabs/puppetdb/conf.d/jetty.ini

A new section is added to the file to ensure the TLSv1 protocol is used when communicating with PuppetDB.


### Setup Requirements **OPTIONAL**

None.

### Beginning with ensuretls

Classify Puppet CA node with: profile::enabletls::console

Classify PuppetDB node with: profile::enabletls::db

## Usage

Please see example profile in: ensuretls/profile/ensuretls/manifests for application of the ensuretls::console and ensuretls::db classes by profile to the Puppet Master nodes.

Note that the following hiera data items will need to be migrated into the appropriate hiera data file.

profile::ensuretls::encryptionmode: 'SSLProtocol TLSv1'
'puppet_enterprise::profile::amq::broker::stomp_transport_options':
  'transport.enabledProtocols': 'TLSv1'

The hiera hash: puppet_enterprise::profile::amq::broker::stomp_transport_options ensures that MCollective operates using TLSv1 ciphers exclusively.


An example default.yaml file containing these data items can be found in hieradata/defaults.yaml within this module.

## Reference

## Limitations

Tested on CentOS 6.5.

## Development


## Release Notes/Contributors/Etc **Optional**

