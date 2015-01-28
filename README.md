# ensuretlsv1

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with ensuretlsv1](#setup)
    * [What ensuretlsv1 affects](#what-ensuretlsv1-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ensuretlsv1](#beginning-with-ensuretlsv1)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module secures encrypted communication between Puppet Master and Agents to be TLSv1.

## Module Description

This module should be classified against Puppet Master nodes only.  The module sshould not be installed on Puppet Agent nodes.

## Setup

Puppet Master nodes may be classified with profile: profiles::ensuretlsv1.
After initial classification, each Puppet Master node must have the Puppet Master service pe-puppet restarted.  This only needs to be done once. 
   
### What ensuretlsv1 affects

The module affects the following files in: /etc/puppetlabs/httpd/conf.d

ssl.conf
puppetdashboard.conf
puppetproxy.conf

The SSLProtocol configuration directive is changed to TLSv1, following classification of a Puppet Master node with the ensuretlsv1 profile.

Additionally, /etc/puppetlabs/puppetdb/conf.d/jetty.ini

A new section is added to the file to ensure the TLSv1 protocol is used when communicating with PuppetDB.


### Setup Requirements **OPTIONAL**

None.

### Beginning with ensuretlsv1

Classify each Puppet Master node with: profiles::enabletlsv1, ensure hiera data element examples in hieradata/default.yaml are migrated into the appropriate hiera file in your infrastructure.

Note:  

'puppet_enterprise::profile::amq::broker::stomp_transport_options':
  'transport.enabledProtocols': 'TLSv1'

Is utilised by the puppet_enterprise::profile::amq::broker class to lock down MCollective communication to TLSv1.


## Usage

Please see example profile in: profile/ensuretls/manifests/init.pp for application of the ensuretls class by profile to the Puppet Master nodes.

Additionally, please see example hieradata in hieradata/defaults.yaml

## Reference

## Limitations

Tested on CentOS 6.5.

## Development


## Release Notes/Contributors/Etc **Optional**

