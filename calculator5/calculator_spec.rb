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

  def test_new_line_delimiter
    assert_equal 10, @calculator.Add("2\n2\n2\n2\n2")
    assert_equal 20, @calculator.Add("3\n3\n3\n3\n3\n3\n2")
    assert_equal 30, @calculator.Add("10\n10\n10")
  end

  def test_custom_delimiters
    assert_equal 10, @calculator.Add("//;;\n1;;2;;3;;4")
    assert_equal 20, @calculator.Add("//..\n1..2..3..4..5..5")
    assert_equal 100, @calculator.Add("//qq\n10qq50qq40")
  end
end

class Calculator
  def self.Add(numbers)
    return 0 if numbers == ''

    delimiters, numbers = get_delimiter_and_clean_input(numbers)

    delimiters.each do |delimiter|
      numbers = numbers.gsub(delimiter, ',')
    end

    numbers.split(',').map(&:to_i).inject(:+)
  end

  def self.get_delimiter_and_clean_input(input)
    delimiter_definition = input.scan(/\/\/\S+\n/)[0]
    if delimiter_definition
      delimiter = Array(delimiter_definition[2..-2])
      input = input.gsub(delimiter_definition, '')
    else
      delimiter = [',', "\n"]
      input = input
    end
    [delimiter, input]
  end
end