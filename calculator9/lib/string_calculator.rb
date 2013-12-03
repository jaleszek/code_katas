module StringCalculator
  def add
   return 0 if self == ''
   raise Exception if numbers.any?{ |num| num < 0 }
   numbers.select{ |number| number <= 1_000 }.inject(:+)
  end

  private

  def numbers
    @numbers ||= normalize_delimiter.split(delimiter).map(&:to_i)
  end

  def delimiter
    ","
  end

  def normalize_delimiter
    str, delimiters = self, ["\n"]

    if start_with?('//')
      end_of_delimiter_definition_index = str.index("\n")
      delimiter_definition = str[2...end_of_delimiter_definition_index]

      if start_with?('//[')
       delimiters += delimiter_definition.split("][").map{ |delim| delim.delete('[').delete(']') }
      else
        delimiters << delimiter_definition
      end

      str = str[end_of_delimiter_definition_index + 1..-1]
    end
   

    delimiters.each do |delim|
      str.gsub!(delim, delimiter)
    end

    str
  end
end
