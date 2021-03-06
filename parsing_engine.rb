class ParsingEngine
	ROMAN_NUMBERS = {'I' => 1, 'V' => 5, 'X' => 10, 'L' => 50, 'C' => 100, 'D' => 500, 'M' => 1000}

	## Converts a number to roman representation. 
  ## Eg: interger_conversion 1904 #=> 'MCMIV'
  def interger_conversion val
    val = val.to_s.split(' ').join('').to_i
    if val != 0 && val.is_a?(Integer)
      $string_builder = [] ## reset string_builder
      digits = val.to_s.split('')
      digit_representation = []
      roman_representation = []

      digits.each_with_index do |num, i|
        digit_representation << (num.to_s + '0'*(digits.size-i-1)).to_i if num != '0'
      end

      digit_representation.each do |int| 
        $string_builder = []
        roman_representation << get_roman(int)
      end
      return roman_representation.flatten.join('')
    end
  end

	## This is the actual recursive logic that converts integer an to roman string
  ## Eg: get_roman 6 #=> 'VI'
  ## Please read more about this method, accepted i/p in README.txt
  def get_roman int
    #puts int
    if int == 0
      return $string_builder
    end
    if int > 1000
      $string_builder = "M"*(int/1000)
      return $string_builder
    end
    if ROMAN_NUMBERS.values.include?(int)
      return ROMAN_NUMBERS.keys[ROMAN_NUMBERS.values.find_index(int)]
    end
    bounds = []
    bounds = findBounds(int)
    upper = bounds[0]
    lower = bounds[1]
    decider = find_remender(upper - int)
    if (decider == 0) or (decider == 1)
      $string_builder << ROMAN_NUMBERS.keys[ROMAN_NUMBERS.values.find_index(upper)]
      if (upper-int) < 0
        return $string_builder
      end
      new_key = get_roman(upper-int)
      if new_key.class != Array
        $temp =  $string_builder
        $string_builder = [new_key]
        $string_builder << $temp
      end
      #$string_builder << new_key if new_key.class != Array
    else
      $string_builder << ROMAN_NUMBERS.keys[ROMAN_NUMBERS.values.find_index(lower)]
      if (int - lower) < 0
        return $string_builder
      end
      new_key = get_roman(int - lower)
      $string_builder << new_key if new_key.class != Array
    end
    return $string_builder
  end

  def find_remender(int)
    while int > 10
      int = int / 10
    end
    return int % 10
  end

  def findBounds(int)
    upper = 1000
    lower = 1000
    values = ROMAN_NUMBERS.values.sort
    values.each_with_index do |v, i|
      if v > int
        upper = v
        lower = values[i-1]
        break
      end
    end
    #puts [upper, lower]
    return [upper, lower]
  end
end

obj = ParsingEngine.new
# obj.load_definition
# obj.process_queries
# obj.read_input
# obj.arithmetic 'MCMXLIV'
# obj.arithmetic 'MMVI'
# obj.arithmetic 'xlii'
 str = gets.to_i
# puts (obj.subtraction_rule str).inspect
# puts (obj.valid_string? str).inspect

# obj.load_definition
# puts (obj.get_roman str).inspect
# puts (obj.arithmetic str)
 puts (obj.interger_conversion str).inspect