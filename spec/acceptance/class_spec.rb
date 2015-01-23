require 'spec_helper_acceptance'

describe 'ensuretlsv1 class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      class { 'ensuretlsv1': }
        (
          $encryptionmode = $ensuretls::params::encryptionmode
        )
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

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
 end
end
