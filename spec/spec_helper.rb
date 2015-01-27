require 'puppetlabs_spec_helper/module_spec_helper'
require 'puppet_facts'
require 'pe_inifile'
include PuppetFacts
include Pe_inifile
RSpec.configure do |c|
  c.formatter = :documentation
end

# The default set of platforms to test again.
ENV['UNIT_TEST_PLATFORMS'] = 'centos-65-x86_64 ubuntu-server-12042-x64'
PLATFORMS = ENV['UNIT_TEST_PLATFORMS'].split(' ')
