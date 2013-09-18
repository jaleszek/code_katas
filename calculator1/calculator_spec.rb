require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calc = Calculator
  end

  def test_empty_string_input
    assert_equal 0, @calc.Add("")
  end

  def test_one_string_input
    assert_equal 2, @calc.Add("2")
  end

  def test_two_string_input
    assert_equal 3, @calc.Add("2,1")
  end

  def test_random_number_of_string_inputs
    10.times do
      digits = rand(100).times.map{ rand(10) }

      assert_equal digits.inject(:+), @calc.Add(digits.join(','))
    end
  end


end

class Calculator

  def self.Add(input)
    digits = input.split(',')
    sum = digits.map(&:to_i).inject(:+)
    sum || 0
  end
end