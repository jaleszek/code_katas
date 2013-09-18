require 'minitest/autorun'
# DO NOT USE SOPHISTICATED CODE IN UNITS, BECAUSE YOU'LL HAVE TO WRITE TESTS TO TESTS
# MOREOVER CHANGES COST A LOT THEN

class TestCalculator < MiniTest::Unit::TestCase
  def setup
    @calc = Calculator
  end

  def test_empty_string_input
    assert_equal 0, @calc.Add("")
  end

  # only commas context 
  def test_random_number_of_string_inputs_as_commas
    10.times do
      digits = (rand(100)+1).times.map{ rand(10) }

      assert_equal digits.inject(:+), @calc.Add(digits.join(','))
    end
  end

  # only new lines context
  def test_random_number_of_string_inputs_as_new_lines
    10.times do
      digits = (rand(100)+1).times.map{ rand(10) }

      assert_equal digits.inject(:+), @calc.Add(digits.join('\n'))
    end
  end

  # mixed new lines and commas context
  def test_random_number_of_string_inputs_as_mixed
    10.times do
      digits = rand(100).times.map{ rand(10) }
      range = rand(digits.size-1) + 1
      input = digits[0..range].join(',') + "," + digits[(range + 1)..-1].join('\n')
      assert_equal digits.inject(:+), @calc.Add(input)
    end
  end


  def test_custom_delimiter_support
    input = '//;;\n1;;2;;3;;4;;5'

    assert_equal 15, @calc.Add(input)
  end
end

class Calculator

  def self.Add(input)
    digits = (has_delimiter?(input) ? custom_splitter(input) : default_splitter(input))
    sum = digits.map(&:to_i).inject(:+)
    sum || 0
  end

  private

  def self.has_delimiter?(input)
    (input =~ /\/\/.+\\n/) == 0
  end

  def self.default_splitter(input)
    input.gsub('\n', ',').split(',')
  end

  def self.custom_splitter(input)
    input.split('\n')[1].split(get_delimitter(input))
  end

  def self.get_delimitter(input)
    input.scan(/\/\/.+\\n/).first[2..-3]
  end
end