module StringCalculator
  def add
    return 0 if self == ''
    raise Error if self.include?('-')

   str = self.dup
   custom_delimiters.each do |del|
      str.gsub!(del, delimiter)
    end

    str = clean_custom_delimiter_definition(str)
    puts str
    require 'ruby-debug'
    add_numbers(str)
  end

  private

  def clean_custom_delimiter_definition(str)
    if str.start_with?("//")
      str[(str.index("\n"))..-1]
    else
      str
    end
  end

  def add_numbers(str)
   ints =  str.split(delimiter).map(&:to_i)
   ints =  ints.select{|int| int <= 1_000 }
   ints.inject(:+)
  end

  def delimiter
    ','
  end

  def custom_delimiters
    delimiters = "\n"
    if self.start_with? "//["
     delimiters = self[2...(self.index("\n"))]
     delimiters = delimiters.split('][')
     delimiters = delimiters.map{|delim| delim.delete("[").delete("]")}
     delimiters
    elsif self.start_with? "//"
      delimiters = self[2...(self.index("\n"))]
     end
    Array(delimiters)
  end
end
