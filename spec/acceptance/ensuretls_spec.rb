require 'spec_helper_acceptance'

describe 'ensuretls class' do

  context 'default parameters' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOS
      require pe_inifile
      class { 'ensuretls': 
        encryptionmode => 'SSLProtocol TLSv1',
      }
      EOS

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end
 end
end
