require 'beaker-rspec'
require 'beaker-rspec/helpers/serverspec'

UNSUPPORTED_PLATFORMS = [ 'Windows', 'Solaris', 'AIX' ]

distmoduledir = [ '/etc/puppet/modules/puppet_enterprise','/etc/puppet/modules/ensuretls' ]

unless ENV['RS_PROVISION'] == 'no'
  hosts.each do |host|
    # Install Puppet
    if host.is_pe?
      install_pe
    else
      # Configure the puppetlabs yum repo
      on host, "rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm"
      on host, "yum-config-manager --enable puppetlabs"
      on host, "yum-config-manager --enable centosplus"
      on host, "yum-config-manager --enable epel"
      # Install the puppet rpm
      install_puppet
      distmoduledir.each do |distmoduledir|
        on host, "mkdir -p #{host['distmoduledir']}"
      end
    end
  end
end

RSpec.configure do |c|
  # Project root
  #proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  proj_root1 = '/Users/davidbryant-moore/Projects/puppetlabs-pe_inifile'
  proj_root2 = '/Users/davidbryant-moore/Projects/ensuretls'
  proj_root3 = '/Users/davidbryant-moore/Projects/puppet_enterprise'
  proj_root4 = '/Users/davidbryant-moore/Projects/puppet_stdlib'
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module
   copy_root_module_to(:host, :source => proj_root1, :module_name => 'pe_inifile')
   copy_root_module_to(:host, :source => proj_root3, :module_name => 'puppet_enterprise')

   puppet_module_install(:source => proj_root1, :module_name => ['puppetlabs-pe_inifile'])
   puppet_module_install(:source => proj_root3, :module_name => ['puppet_enterprise'])
   puppet_module_install(:source => proj_root2, :module_name => ['ensuretls'])
   puppet_module_install(:source => proj_root2, :module_name => ['stdlib'])
    hosts.each do |host|
      on host, puppet('module','install','puppetlabs-stdlib'), { :acceptable_exit_codes => [0,1] }
    end
  end
end
