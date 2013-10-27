require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

Spec::Matchers.define :add_to do |expected|
  match do |string|
    (@result = string.extend(StringCalculator).add) == expected
  end

  failure_message_for_should do |string|
    "Expected #{string} to add #{expected}, but got #{@result}"
  end
end

describe StringCalculator, '#add' do
  it { ''.should add_to(0) }

  context 'single number' do
    it { '0'.should add_to(0) }
    it { '1'.should add_to(1) }
    it { '24'.should add_to(24) }
  end

  context '2 numbers' do
    it { '0,0'.should add_to(0)}
    it { '1,12'.should add_to(13)}
    it { '43,11'.should add_to(54)}
  end

  context '3 numbers' do
    it { '1,2,3'.should add_to(6)}
    it { '24,2,1'.should add_to(27)}
    it { '0,0,0'.should add_to(0)}
  end

  it 'supports new line delimiter' do
    "1\n2\n3\n4".should add_to(10)
  end

  it 'supports mixed delimiters' do
    "1\n2\n3,4\n5,6".should add_to(21)
  end

  it 'supports custom delimiter' do
    "//;\n1;2;3;4".should add_to(10)
  end

  context 'negative numbers' do
    it 'raises an exceptions if it finds one' do
      lambda { "-1".extend(StringCalculator).add}.should raise_error
    end

    it 'includes negative numbers in the message' do
      lambda { "-1,12,-2,33".extend(StringCalculator).add}.should raise_error("Negatives are not allowed: -1, -2")
    end
  end
end