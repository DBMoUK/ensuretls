# == Class: ensuretls::master
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
#  class { 'ensuretls::master':
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
class ensuretls::master (
  $jvmencryptionmode = $ensuretls::params::jvmencryptionmode
)
inherits ensuretls::params {

  $templatepath='/opt/puppet/share/puppet/modules/puppet_enterprise/templates/master/puppetserver/'

  File_line {
    line   => $jvmencryptionmode,
    ensure => present,
    match  => "^\\s+ssl-protocol\\s+",
  }

  service { 'pe-puppetserver':
    ensure => running,
  }

  file_line {'webserver.conf':
    path   => "${templatepath}/webserver.conf.erb",
    line   => $jvmencryptionmode, 
    ensure => present,
    match  => "^\\s+ssl-pprotocols\\s+"
    notify => Service['pe-puppetserver'],
  }

}
