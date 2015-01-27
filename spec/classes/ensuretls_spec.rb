require 'spec_helper_acceptance'

describe 'ensuretls class' do

  describe 'running puppet code' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      tmpdir = default.tmpdir('ensuretls')
      pp = <<-EOS
        class { 'ensuretls':
          ( encryptionmode => $ensuretls::params::encryptionmode )
          inherits ensuretls::params {

          $confpath='/etc/puppetlabs/httpd/conf.d'
          $protocol = split($encryptionmode,' ')

          File_line {
            line   => $encryptionmode,
            ensure => present,
            match  => "^\\s+SSLProtocol\\s+",
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

          pe_ini_setting {'puppetdb_tlsmode':
            path    => '/etc/puppetlabs/puppetdb/conf.d/jetty.ini',
            section => 'ssl-host',
            setting => 'ssl-protocols',
            value   => $protocol[-1],
          }

        }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
  end
end

