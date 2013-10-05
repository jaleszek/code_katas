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

  def test_unknown_arg_input
    assert_equal 10, @calculator.Add('5,2,2,1')
    assert_equal 20, @calculator.Add('5,5,2,2,2,2,2')
    assert_equal 30, @calculator.Add('5,5,5,5,1,1,4,4')
    assert_equal 40, @calculator.Add('10,5,5,5,5,2,2,2,2,2')
  end
end

class Calculator
  def self.Add(numbers)
    return 0 if numbers == ''

    numbers.split(',').map(&:to_i).inject(:+)
  end
end