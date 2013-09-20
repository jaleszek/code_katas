require 'minitest/autorun'

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calculator = Calculator
  end


  def test_zero_digit_input
    assert_equal 0, @calculator.Add('')
  end

  def test_one_digits_input
    assert_equal 10, @calculator.Add('10')
  end

  def test_two_digits_input
    assert_equal 10, @calculator.Add('5,5')
  end

  def test_various_length_of_arguments
    assert_equal 30, @calculator.Add('10,10,10')
    assert_equal 50, @calculator.Add('10,10,10,10,10')
    assert_equal 50, @calculator.Add('0,0,0,0,0,0,0,0,0,0,0,50')
  end

  def test_new_line_delimiter
    assert_equal 30, @calculator.Add("10\n10\n10")
    assert_equal 30, @calculator.Add("10,10\n10")
    assert_equal 30, @calculator.Add("5\n5\n5,5,5\n5")
  end

  def test_custom_delimiter
    assert_equal 10, @calculator.Add("//;;\n3;;3;;3;;1")
    assert_equal 10, @calculator.Add("//[[\n3[[3[[3[[1")
  end
end

class Calculator
  CUSTOM_DELIMITER_REGEX = /\/\/.+\n/

  def self.Add(input)
    return 0 if input == ''
    format(input).split(',').map(&:to_i).inject(:+)
  end

  private

  def format(input)
    if s = get_delimiter(input)
      
    else
    end

  end

  def default_formatter(input)
    input.gsub()
  end

  def get_delimiter(input)
    input.scan(CUSTOM_DELIMITER_REGEX)[2..-2]
  end

  def remove_delimiter_definition(input)
    input.gsub(CUSTOM_DELIMITER_REGEX, '')
  end
end