# == Class: profile::ensuretlsv::console
#
# Ensure communication between Master & Agent components secured over TLSv1.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'profile::ensuretlsv::console':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# David Bryant-Moore <david.bmoore@puppetlabs.com>
#
# === Copyright
#
# Copyright 2015 Puppetlabs.
#
class profile::ensuretls::console (
  $encryptionmode = $ensuretls::console::params::encryptionmode
)
inherits profile::ensuretls::params {

  $confpath='/etc/puppetlabs/httpd/conf.d'

  File_line {
    line   => $encryptionmode,
    ensure => present,
    match  => "^\\s+SSLProtocol\\s+",
    notify => Service['pe-httpd'],
  }

  service { 'pe-httpd':
    ensure => running,
    enable => true,
  }

  file_line {'ssl.conf':
    path  => "${confpath}/ssl.conf",
  }

  file_line {'puppetproxy.conf':
    path => "${confpath}/puppetproxy.conf",
  }

  file_line {'puppetdashboard.conf':
    path => "${confpath}/puppetdashboard.conf",
  }
}
