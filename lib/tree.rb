require_relative 'node'

class Tree 
  attr_accessor :root

  def initialize(array)
    # Build the tree from the cleaned up array, set the return node to be the root
    self.root = build_tree(array.uniq.sort)
  end

  def build_tree(array)
    # Return nil if the array is empty
    return nil if array.empty?

    # Find the middle index and take that value as data
    mid = (array.length - 1) / 2
    data = array[mid]
    # Recursively build a tree from the slices left and right to the mid index
    left_node = build_tree(array[0...mid])
    right_node = build_tree(array[mid + 1..-1])
    # Return the root node of the tree
    Node.new(data, left_node, right_node)
  end

    # Pretty print method shared on Discord, made available in the assignment itself
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
     end
end
