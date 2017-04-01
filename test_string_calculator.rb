require 'minitest/autorun'

class StringCalculator
  NEWLINE_DELIMITER = '\n'
  DEFAULT_DELIMITER = ','
  CUSTOM_DELIMITER = '//'
  
  def calculate(input)
    @input = input
    @delimiter = NEWLINE_DELIMITER
    
    support_different_delimiters
    normalize_delimiter
    numbers = convert_string_to_integers
    calculate_sum(numbers)
  end
  
  private
  
  def support_different_delimiters
    if @input.start_with?(CUSTOM_DELIMITER)
      @delimiter = @input[2]
      @input = @input[5, @input.length - 1]      
    end
  end
  
  def convert_string_to_integers
    strings = @input.split(',')
    strings.map{|x| x.to_i}
  end
  
  def calculate_sum(numbers)
    numbers.inject(0){|sum, num| sum+num}
  end
  
  def normalize_delimiter
    @input.gsub!(@delimiter, DEFAULT_DELIMITER)
  end
end

describe StringCalculator do
  
  it "returns 3 for string '//;\n1;2'" do
    calculator = StringCalculator.new
    
    result = calculator.calculate('//;\n1;2')
    
    assert_equal 3, result        
  end
  
  it 'returns 6 for string 1\n2,3' do
    calculator = StringCalculator.new
    
    result = calculator.calculate('1\n2,3')
    
    assert_equal 6, result    
  end
  
  it 'returns 0 for empty string' do
    calculator = StringCalculator.new
    
    result = calculator.calculate('')
    
    assert_equal 0, result
  end
  
  it 'returns 1 for string 1' do
    calculator = StringCalculator.new
    
    result = calculator.calculate('1')
    
    assert_equal 1, result    
  end
  
  it 'returns 3 for string 1,2' do
    calculator = StringCalculator.new
    
    result = calculator.calculate('1,2')
    
    assert_equal 3, result        
  end
  
  it 'returns 10 for string 1,2,3,4' do
    calculator = StringCalculator.new
    
    result = calculator.calculate('1,2,3,4')
    
    assert_equal 10, result            
  end
end