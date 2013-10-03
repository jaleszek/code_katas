require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calculator = Calculator
  end

  def test_null_input
    assert_equal 0, @calculator.Add('')
  end

  def test_various_number_of_arguments
    inputs = {
      1 => '1',
      10 => '5,2,3',
      20 => '5,5,5,5',
      30 => '5,5,5,5,5,5',
      50 => '5,5,10,10,5,5,5,5',
      50 =>  "5\n5,5\n5,10\n5\n5,10",
      50 => "5\n5\n10\n10\n10\n10"
    }
    inputs.each do |sum, input|
      assert_equal sum, @calculator.Add(input)
    end

  end
end


class Calculator

  def self.Add(input)
    return 0 if input == ''
    supported_delimiters = [',', "\n"]

    supported_delimiters.each do |delimiter|
      input = input.gsub(/#{delimiter}/, ',')
    end

    input.split(',').map(&:to_i).inject(:+)
  end
end