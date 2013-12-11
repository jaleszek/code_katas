require 'ruby-debug'

module StringCalculator
  def add
    return 0 if self == ''
    raise Exception if has_negative_number?

    cut_off_big_numbers.inject(:+)
  end

  private

  def cut_off_big_numbers
    numbers.select{ |number| number <= 1000 }
  end

  def has_negative_number?
    numbers.select { |number| number < 0 }.length > 0
  end

  def numbers
    @numbers ||= normalize_delimiter(self).split(final_delimiter).map(&:to_i)
  end

  def normalize_delimiter(input)
    delimiters = supported_delimiters
    if input.start_with?('//')
      if input.start_with?('//[')
        end_of_definition_index = input.index("\n")
        delimiter_definition = input[3..end_of_definition_index]

        custom_delimiters = delimiter_definition.split('][').map do |delim|
          delim.delete('[').delete(']').delete("\n")
        end
        delimiters = delimiters + custom_delimiters
        input = input[end_of_definition_index+1..-1]
      else
        delimiters << input[2]
        input = input[4..-1]
      end
    end


    delimiters.each do |delim|
      input = input.gsub(delim, final_delimiter)
    end
    input
  end

  def supported_delimiters
    [',', "\n"]
  end

  def final_delimiter
    ','
  end
end