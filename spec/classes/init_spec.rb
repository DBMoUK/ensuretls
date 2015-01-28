require 'spec_helper'
describe 'ensuretls' do

  context 'with defaults for all parameters' do
    it { should contain_class('ensuretls') }
  end
end
