require_relative "chisel_parser"

input_file = ARGV[0]
Chisel.new(input_file).package_output_file
