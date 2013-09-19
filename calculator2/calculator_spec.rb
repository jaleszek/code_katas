# 10:21
require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calculator = Calculator.new
  end

  def test_for_empty_input
    assert_equal 0, @calculator.Add('')
  end

  def test_for_one_digit_input
    assert_equal 10, @calculator.Add('10')
  end

  def test_for_two_digits_input
    assert_equal 23, @calculator.Add('20,3')
  end

end

class Calculator
  def Add(digits)
    return 0 if digits.eql?('')
    digits.split(',').map(&:to_i).inject(:+)
  end
end