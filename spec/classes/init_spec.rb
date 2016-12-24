require 'spec_helper'
describe 'splunk' do

  context 'with defaults for all parameters' do
    it { should contain_class('splunk') }
  end
end
