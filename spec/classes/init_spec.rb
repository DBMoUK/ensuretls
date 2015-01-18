require 'spec_helper'
describe 'ensuretlsv1' do

  context 'with defaults for all parameters' do
    it { should contain_class('ensuretlsv1') }
  end
end
