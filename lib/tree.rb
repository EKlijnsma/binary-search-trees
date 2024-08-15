  # frozen_string_literal: true

  require_relative 'node'

  class Tree
    PREORDER = 0
    INORDER = 1
    POSTORDER = 2
    
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
      right_node = build_tree(array[mid + 1..])
      # Return the root node of the tree
      Node.new(data, left_node, right_node)
    end

    def find(value)
      value = Node.new(value)
      current_node = root

      loop do
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

      loop do
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

    def delete(value, root = @root)
      # remove value from left or right tree
      if value > root.data
        # delete value from the right subtree if value is larger than root
        root.right = delete(value, root.right)
      elsif value < root.data
        # delete value from the left subtree if value is smaller than root
        root.left = delete(value, root.left)
      else
        # in this case the current root must be deleted
        # If one child is nil, return the other child.
        return root.left if root.right.nil?
        return root.right if root.left.nil?

        # If 2 child nodes, find successor, replace target value with successor value and remove successor
        successor = min_value_node(root.right)
        root.data = successor.data
        root.right = delete(successor.data, root.right)
      end
      # return the updated root
      root
    end

    def min_value_node(root)
      min = root
      until root.left.nil?
        root = root.left
        min = root
      end
      min
    end

    # Pretty print method shared on Discord, made available in the assignment itself
    def pretty_print(node = @root, prefix = '', is_left = true)
      pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
      puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
      pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end

    def level_order(root = @root)
      # Level order traversal = first the root, then depth 1 left to right, then depth 2 left to right, etc.
      discovered_nodes = [root]
      level_order_nodes = []
      until discovered_nodes.empty?
        # Take first item from the queue
        current_node = discovered_nodes.shift
        # Enqueue its children (if any)
        discovered_nodes << current_node.left if current_node&.left
        discovered_nodes << current_node.right if current_node&.right
        # Add node to ordered array
        level_order_nodes << current_node
      end
      # when no more nodes are enqueued, yield to the block, or return data
      if block_given?
        level_order_nodes.each { |node| yield node }
      else
        level_order_nodes.map(&:data)
      end
    end

    def preorder(root = @root)
      # Order nodes recursively with helper function
      ordered = helper_order(root, PREORDER)

      # After ordering nodes, yield to the block, or return data
      if block_given?
        ordered.each { |node| yield node }
      else
        ordered.map(&:data)
      end
    end

    def inorder(root = @root)
      # Order nodes recursively with helper function
      ordered = helper_order(root, INORDER)

      # After ordering nodes, yield to the block, or return data
      if block_given?
        ordered.each { |node| yield node }
      else
        ordered.map(&:data)
      end
    end
    
    def postorder(root = @root)
      # Order nodes recursively with helper function
      ordered = helper_order(root, POSTORDER)

      # After ordering nodes, yield to the block, or return data
      if block_given?
        ordered.each { |node| yield node }
      else
        ordered.map(&:data)
      end
    end
    
    def helper_order(root, order)
      return [] if root.nil?

      ordered_nodes = []
      case order
      when PREORDER
        # Pre order is Root, Left subtree, Right subtree
        ordered_nodes.push(root)
        ordered_nodes.concat(helper_order(root.left, order))
        ordered_nodes.concat(helper_order(root.right, order)) 
      when INORDER
        # In order is Left subtree, Root, Right subtree
        ordered_nodes.concat(helper_order(root.left, order))
        ordered_nodes.push(root)
        ordered_nodes.concat(helper_order(root.right, order))
      when POSTORDER
        # Post order is Left subtree, Right subtree, Root
        ordered_nodes.concat(helper_order(root.left, order))
        ordered_nodes.concat(helper_order(root.right, order)) 
        ordered_nodes.push(root)
      else
        nil
      end
      ordered_nodes
    end

    def height(node)
      # Base case if the node is nil return -1 to allow proper calculation 
      return -1 if node.nil?
    
      # Recursively calculate height of left and right subtrees
      height_left = height(node.left)
      height_right = height(node.right)
      
      # Return the highest number, + 1 for the current Node (in case of a leave node, this makes height 0)
      [height_left, height_right].max + 1 
    end

    def depth(node, current_node = @root, current_depth = 0)
      # Base case, node not found in the tree
      return nil if current_node.nil?

      # Base case, node found
      return current_depth if node == current_node

      # Continue searching in the appropriate subtree
      if node < current_node
        depth(node, current_node.left, current_depth + 1)
      else
        depth(node, current_node.right, current_depth + 1)
      end        
    end

    def balanced?(node = @root)
      # Base case, a nil node is balanced
      return true if node.nil?

      # Calculate heights
      height_left = height(node.left)
      height_right = height(node.right)

      # Tree is balanced if the current node is balanced, and both subtrees are
      if (height_left - height_right).abs <= 1 && balanced?(node.left) && balanced?(node.right)
        return true
      else
        return false
      end
    end

    def rebalance
      # Get the tree values in order
      data = self.inorder
      # rebuild the tree
      self.root = build_tree(data)
    end
  end
