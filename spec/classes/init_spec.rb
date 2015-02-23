require 'spec_helper'
describe 'dmsetup' do

  context 'with defaults for all parameters' do
    it { should contain_class('dmsetup') }
  end
end
