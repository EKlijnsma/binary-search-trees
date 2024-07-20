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

  def find(value)
    value = Node.new(value)
    current_node = root

    while true do
      # Return node if the value was found
      return current_node if current_node.nil? || value == current_node
      # Otherwise, determine the direction and update the current node
      direction = (value > current_node ? :right : :left)
      current_node = current_node.send(direction)
    end
  end

  def insert(value)
    # Create new node and initiate current node to root node
    new_node = Node.new(value)
    current_node = root
    
    while true do
      # Determine the direction
      direction = (new_node > current_node ? :right : :left)
      if current_node.send(direction).nil?
        # Insert node and break if no further nodes exists here
        current_node.send("#{direction}=", new_node)
        break
      else
        # Change current node to the next node
        current_node = current_node.send(direction)
      end
    end
    # Return the newly inserted node
    new_node
  end

    # Pretty print method shared on Discord, made available in the assignment itself
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
     end
end
