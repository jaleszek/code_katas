module StringCalculator
  def add
    return 0 if empty?
    raise_if_negatives_present

    digits.map(&:to_i).inject(:+)
  end

  def digits
    gsub("\n", delimiter).split(delimiter).map(&:to_i)
  end

  def delimiter
    @delimiter ||= (self[0,2] == '//' ? self[2,1] : ',')
  end

  def raise_if_negatives_present
    raise "Negatives are not allowed: #{negatives.join(', ')}" if negatives.any?
  end

  def negatives
    @negatives ||= digits.select{ |digit| digit < 0 }
  end

end