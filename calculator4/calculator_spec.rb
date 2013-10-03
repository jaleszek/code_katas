require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calculator = Calculator
  end

  def test_null_input
    assert_equal 0, @calculator.Add('')
  end

  def test_one_argument_input
    assert_equal 1, @calculator.Add('1')
  end

  def test_two_arguments_input
    assert_equal 4, @calculator.Add('2,2')
  end

  def test_various_number_of_arguments
    inputs = {
      10 => '5,2,3',
      20 => '5,5,5,5',
      30 => '5,5,5,5,5,5',
      50 => '5,5,10,10,5,5,5,5'
    }
    inputs.each do |sum, input|
      assert_equal sum, @calculator.Add(input)
    end

  end
end


class Calculator

  def self.Add(input)
    return 0 if input == ''

    input.split(',').map(&:to_i).inject(:+)
  end
end