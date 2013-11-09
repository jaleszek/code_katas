require 'spec_helper'

Spec::Matchers.define :add_to do |expected|
  match do |string|
    string.extend(StringCalculator).add == expected
  end

  failure_message_for_should do |actual|
    "expected that would be #{expected} but got #{actual}"
  end
end

describe String, '#add' do
  
  context 'no argument' do
    it { "".should add_to(0) }    
  end

  context 'one argument' do
    it { "0".should add_to(0) }
    it { "1".should add_to(1) }
    it { "999".should add_to(999) }
  end

  context 'two arguments' do
    it { "0,0".should add_to(0) }
    it { "1,1".should add_to(2) }
    it { "999,1".should add_to(1000) }
  end

  context 'unknown amount of arguments' do
    it {"0,0,0,2,0".should add_to(2) }
    it {"2,1,2,22,2,0".should add_to(29) }
    it {"1,10,100,100,1,1".should add_to(213) }
  end

  context 'new line delimiter' do
    it {"0\n12\n1,1\n1".should add_to(15) }
    it {"1,2,\n4\n4,1".should add_to(12) }
  end

  context 'custom delimiter' do
    context 'single delimiter' do
      it {"//;\n1;2;3;4;5".should add_to(15) }
      it {"//m\n1m2m3m4m5".should add_to(15) }
      it {"//^\n1^2^3^4^5".should add_to(15) }
    end

    context 'any length delimiter' do
      it { "//;;;\n1;;;2;;;3;;;4;;;5".should add_to(15) }
      it {"//*;\n1*;2*;3*;4*;5".should add_to(15) }
    end

    context 'any number of delimiters' do
      it { "//[;][,]\n1;2,3;4,5".should add_to(15)}
      it { "//[;;][,;][bc]\n1;;2,;3bc4bc5".should add_to(15)}
    end
  end

  it "raises error when negative input" do
    lambda{"1,-2,-3,1".extend(StringCalculator).add }.should raise_error
  end

  context 'big numbers' do
    it 'skips numbers bigger than 1000' do
      "1000,1000000000,2,1000000,1".should add_to(1003)
    end
  end
end
