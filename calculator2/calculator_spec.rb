# 10:21
require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calculator = Calculator.new
  end

  def test_for_empty_input
    assert_equal 0, @calculator.Add('')
  end

  def test_for_various_length_inputs
    assert_equal 10, @calculator.Add('10')
    assert_equal 20, @calculator.Add('10,10')
    assert_equal 30, @calculator.Add('10,10,10')
    assert_equal 101, @calculator.Add('1,0,0,0,100')
  end

end

class Calculator
  def Add(digits)
    return 0 if digits.eql?('')
    digits.split(',').map(&:to_i).inject(:+)
  end
end