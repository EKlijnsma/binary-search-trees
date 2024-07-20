# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 63, 324]
test = Tree.new(array)

test.pretty_print
puts "\n\n"
test.delete(8)
test.delete(9)
test.pretty_print
