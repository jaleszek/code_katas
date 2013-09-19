# 10:21
require 'debugger'
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
    assert_equal 30, @calculator.Add("10\n10\n10")
    assert_equal 30, @calculator.Add("10\n5\n5\n10")
    assert_equal 30, @calculator.Add("15\n15")
  end

  # context for new lines and commas mixed
  def test_for_various_length_inputs_for_mixed_delimiters
    assert_equal 30, @calculator.Add("10,10\n10")
    assert_equal 30, @calculator.Add("5\n5\n5,5\n5,5")
    assert_equal 30, @calculator.Add("5\n5\n5,5,5\n5")
  end

  # context custom delimiters
  def test_for_custom_delimiter
    delimiters = [';', '[[', '..']

    delimiters.each do |delimiter|
      assert_equal 30, @calculator.Add("//#{delimiter}\n10#{delimiter}10#{delimiter}10")
    end
  end

  def test_custom_delimiter_regex
    assert_equal 0, @calculator.class::CUSTOM_DELIMITER_REGEX =~ "//;;;\n100;;;1000;;;10"
  end

  def test_clean_input
    assert_equal '10;;10;;10', @calculator.send(:clean_input, "//;;\n10;;10;;10")
  end

end

class Calculator
  CUSTOM_DELIMITER_REGEX = /\/\/.+\n/

  def Add(digits)
    return 0 if digits.eql?('')
    if custom_delimiter = get_custom_delimiter_and_clean_input(digits)
      custom_splitter(digits, custom_delimiter)
    else
      default_splitter(digits)
    end
  end

  private

  def default_splitter(digits)
    digits.gsub("\n", ',').split(',').map(&:to_i).inject(:+)
  end

  def custom_splitter(digits, delimiter)
    digits.split(delimiter).map(&:to_i).inject(:+)
  end

  def get_custom_delimiter_and_clean_input(digits)
    out = digits.scan(CUSTOM_DELIMITER_REGEX)[0]

    if out && out != ''
      out = out[2..-2]
      digits = clean_input(digits)
    end

    out
  end

  def clean_input(digits)
    digits.gsub(CUSTOM_DELIMITER_REGEX, '')
  end
end