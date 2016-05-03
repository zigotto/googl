require 'spec_helper'

describe StringHelper do
  context 'when underscoring' do
    subject { StringHelper.underscore('CamelCaseString') }
    
    it { is_expected.to eq('camel_case_string') }
  end

  context 'when preventing String class mutation' do
    it 'raises a NoMethod error' do
      expect { 'CamelCaseString'.underscore }.to raise_error(NoMethodError)
    end
  end
end