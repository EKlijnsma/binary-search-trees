# frozen_string_literal: true

require_relative 'lib/node'
require_relative 'lib/tree'

# Create a binary search tree from an array of random numbers
tree = Tree.new((Array.new(15) { rand(1..100) }))

# Print the tree
tree.pretty_print

# Confirm that the tree is balanced by calling #balanced?
puts "Tree balanced? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order
print "Level order: "
p tree.level_order
print "Pre order: "
p tree.preorder
print "Post order: "
p tree.postorder
print "In order: "
p tree.inorder

# Unbalance the tree by adding several numbers > 100
5.times { tree.insert(rand(101..200)) }
tree.pretty_print

# Confirm that the tree is unbalanced by calling #balanced?
puts "Tree balanced? #{tree.balanced?}"

# Balance the tree by calling #rebalance
tree.rebalance
tree.pretty_print

# Confirm that the tree is balanced by calling #balanced?
puts "Tree balanced? #{tree.balanced?}"

# Print out all elements in level, pre, post, and in order.
print "Level order: "
p tree.level_order
print "Pre order: "
p tree.preorder
print "Post order: "
p tree.postorder
print "In order: "
p tree.inorder
