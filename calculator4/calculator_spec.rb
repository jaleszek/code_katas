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

  def test_custom_delimiter
    inputs = {
      10 => "//;;\n1;;8;;1",
      20 => "//[]\n5[]10[]1[]3[]1",
      30 => "//,.\n5,.10,.10,.5"
    }
    inputs.each do |sum, input|
      assert_equal sum, @calculator.Add(input)
    end
  end

  def test_negative_input
    err = assert_raises(Exception){ @calculator.Add('-10,10,11,12,-11')}
    assert_match /-10, -11/, err.message
    assert_match /negatives not allowed/, err.message
  end

  def test_ignore_bigger_numbers
    inputs ={
      10 => '1001,1001,1001,2,1001,8',
      10 => '2,1000000,2,6,10000'
    }
    inputs.each do |sum, input|
      assert_equal sum, @calculator.Add(input)
    end
  end
end


class Calculator

  def self.Add(input)
    return 0 if input == ''

    input = standardize(*custom_delimiter(input))
    collect_numbers(input)
  end

  private

  def self.standardize(input, delimiters)
    delimiters.each do |delimiter|
      input = input.gsub(delimiter, ',')
    end
    input
  end

  def self.collect_numbers(input)
    numbers = input.split(',').map(&:to_i)
    negative_numbers = numbers.select{|number| number < 0 }
    raise Exception.new("negatives not allowed: #{negative_numbers.join(', ')} ") unless negative_numbers.size == 0
    numbers.select!{ |number| number <= 1_000}
    numbers.inject(:+)
  end

  def self.custom_delimiter(input)
    definition = input.scan(/\/\/\S+\n/)
    if deff = definition.first
      input = (input.gsub(deff, ''))
      delimiter = Array(deff[2..-2])
    else
      input = input
      delimiter = [',', "\n"]
    end

    [input, delimiter]
  end
end