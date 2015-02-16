# Module ensuretls

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

The classes contained in this module should be classified against: 
Puppet Console, PuppetDB, and Puppet CA Master [Master of Master] 
nodes only.  

The module also contains an additional provider for the file_line
resource, which allows use of both the 'match' and 'after' resources
so as to ensure that files managed using the file_line resource
type can and will only contain 1 reference for the appropriate 
configuration directive.  Thanks to Chris Price @ Puppetlabs 
for providing this.

You may classify appropriate nodes using either the provided profile
wrapper classes, which source Hiera data, or you may use the classes
themselves which use the parameters pattern to consume the 
configuration data parameters: encryptionmode, jvmencryptionmode.
Otherwise, the function of each profile wrapper class simply declares
the appropriate base class.

The ensuretls::master class, or the wrapper profile: 
profile::ensuretls::master should #not# be applied to Compile Master
nodes in a Split-Install implementation.

An All-In-One Master may be classified with all three classes.

These module should #not# be installed on Puppet Agent nodes.

## Setup

Puppet Master Console node may be classified with the profile
wrapper class: 
profile::ensuretls::console

Alternatively, it may be classified with:

ensuretls::console

PuppetDB Node may be classified with the profile wrapper class: 
profile::ensuretls::db

After classification, the node appropriate service is notified of the 
changes: pe-httpd on the Console node, pe-puppetdb on the DB node,
and pe-puppetserver on the CA Master node.  
 
### What ensuretls::console affects

The module affects the following files in: /etc/puppetlabs/httpd/conf.d

ssl.conf
puppetdashboard.conf
puppetproxy.conf

The SSLProtocol configuration directive is changed to TLSv1, following 
classification of a Puppet Master node with  
profile::ensuretls::console profile.

### What ensuretls::db affects

/etc/puppetlabs/puppetdb/conf.d/jetty.ini

A new section is added to the file to ensure the TLSv1 protocol is used when communicating with PuppetDB.

### What ensuretls::master affects

/opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/puppetserver/webserver.conf.erb

A new directive is added to the file to lock down Master <--> Agent communication to TLSv1.

Patching the source template for webserver.conf.erb is an interim measure until
Engineering@Puppetlabs release an official fix for this requirement.

### Setup Requirements **OPTIONAL**

None.

### Beginning with ensuretls

In a Split-Install implementation:


Classify Puppet Console node with profile wrapper class: 
profile::ensuretls::console
or
ensuretls::console

Classify PuppetDB node with profile wrapper class:
profile::ensuretls::db
or
ensuretls::db

Classify #only the CA Master# with 
with profile wrapper class:
profile::ensuretls::master
or
ensuretls::master


In an All-In-One implementation:

Classify Puppet Master with profile wrapper classes: 
profile::ensuretls::console
profile::ensuretls::db
profile::ensuretls::master

or 

ensuretls::console
ensuretls::db
ensuretls::master

## Usage

Please see example profile in: ensuretls/profile-example/profile/manifests/ensuretls
for application of the ensuretls::console and ensuretls::db classes by 
profile wrapper class to the appropriate Puppet nodes.

Note that the following hiera data items will need to be migrated into
the appropriate hiera data file.

profile::ensuretls::encryptionmode: 'SSLProtocol TLSv1'
profile::ensuretls::jvmencryptionmode: 'ssl-protocol: ['TLSv1']'
'puppet_enterprise::profile::amq::broker::stomp_transport_options':
  'transport.enabledProtocols': 'TLSv1'

The hiera hash: puppet_enterprise::profile::amq::broker::stomp_transport_options ensures that MCollective operates using TLSv1 ciphers exclusively.  This hiera data item must be available on the Puppet Master which serves the MCollective Agent process.

Please note, after making changes to Hiera, the Puppet Master hosting Hiera needs to have the pe-puppet service restarted in order for the changes to becoe available to Puppet.


An example default.yaml file containing these data items can be found in hieradata/defaults.yaml within this module.

## Reference

## Limitations

Tested on CentOS 6.5.

## Development


## Release Notes/Contributors/Etc **Optional**

