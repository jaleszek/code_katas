# 10:21
require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calculator = Calculator.new
  end

  def test_for_empty_input
    assert_equal 0, @calculator.Add('')
  end

  # context for commas only
  def test_for_various_length_inputs_for_commas
    assert_equal 10, @calculator.Add('10')
    assert_equal 20, @calculator.Add('10,10')
    assert_equal 30, @calculator.Add('10,10,10')
    assert_equal 101, @calculator.Add('1,0,0,0,100')
  end

  # context for new lines only
  def test_for_various_length_inputs_for_new_lines
    assert_equal 30, @calculator.Add('10\n10\n10')
    assert_equal 30, @calculator.Add('10\n5\n5\n10')
    assert_equal 30, @calculator.Add('15\n15')
  end

  # context for new lines and commas mixed
  def test_for_various_length_inputs_for_mixed_delimiters
    assert_equal 30, @calculator.Add('10,10\n10')
    assert_equal 30, @calculator.Add('5\n5\n5,5\n5,5')
    assert_equal 30, @calculator.Add('5\n5\n5,5,5\n5')
  end

end

class Calculator
  def Add(digits)
    return 0 if digits.eql?('')
    digits.split(',').map(&:to_i).inject(:+)
  end
end