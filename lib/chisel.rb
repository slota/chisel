class Chisel

#  attr_reader :parse  # => nil

  def initialize(input_string)
    @input_string = input_string
  end

  def parse
    #@input_string
    if @input_string.start_with? "#"
      @input_string = "<h#{number}>#{string}</h#{number}>"
    elsif
      @input_string.end_with? "\n\n"
      @input_string = "<p>#{string_paragraph}</p>"
    elsif
      @input_string.end_with? "\n"
      @input_string = "<p>#{string_paragraph}</p>"
    end
    # if @input_string == "hello\n"
    #   # require 'pry'
    #   # binding.pry
    #   @input_string = @input_string.split("\n")
    # end
    @input_string
  end

  def number
    counter = 0
    @input_string.chars.each do |hash|
      if hash == "#"
       counter += 1
      end
    end
    counter
  end

  def string
    info = @input_string.chars[number..-1]
    # require 'pry'
    # binding.pry
    if info.nil?
      info = ""
    else
      info.join.lstrip
    end
  end

  def string_paragraph
    info = @input_string.gsub("\n", "" )
  end

end
