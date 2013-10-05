require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calculator = Calculator
  end

  def test_empty_input
    assert_equal 0, @calculator.Add('')
  end

  def test_one_arg_input
    assert_equal 5, @calculator.Add('5')
  end

  def test_two_arg_input
    assert_equal 10, @calculator.Add('5,5')
  end
end

class Calculator
  def self.Add(numbers)
    return 0 if numbers == ''

    numbers.split(',').map(&:to_i).inject(:+)
  end
end