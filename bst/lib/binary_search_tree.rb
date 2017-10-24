# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'byebug'
require_relative "bst_node"
class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    node = BSTNode.new(value)
    return @root = node if @root.nil?
    insert_into_position(node, @root)
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    if value == tree_node.value
      tree_node
    elsif value < tree_node.value
      find(value, tree_node.left)
    else
      find(value, tree_node.right)
    end
  end

  def delete(value)
    # step 1: find(value)
    node = find(value)
    # calculate num kids
    kids = 0
    kids += 1 if node.left
    kids += 1 if node.right

    case kids
    when 0
      remove_childless_node(node)
    when 1
      remove_one_child_node(node)
    when 2
      remove_two_child_node(node)
    end
    # set node pointers to nil
    node.left = nil
    node.right = nil
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node if tree_node.right.nil?
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    @max_depth = 0
    num_depth(0, tree_node)
    @max_depth
  end

  def is_balanced?(tree_node = @root)
    @balance = true
    check_balance(tree_node)
    @balance
  end

  def check_balance(tree_node = @root)
    return unless tree_node
    return if @balance == false
    left = 0
    right = 0

    left = depth(tree_node.left) if tree_node.left
    right = depth(tree_node.right) if tree_node.right

    check_balance(tree_node.left) if tree_node.left
    check_balance(tree_node.right) if tree_node.right

    val = left - right
    @balance = false unless [-1, 0, 1].include?(val)
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return unless tree_node
    in_order_traversal(tree_node.left, arr)
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr)
    arr
  end

  private
  # optional helper methods go here:
  def insert_into_position(node, tree_node = @root)
    # 1. Compare
    comp = node.value <=> tree_node.value
    case comp
    when -1
      # 2a. Sets left child if it is nil
      if tree_node.left.nil?
        node.parent = tree_node
        tree_node.left = node
      else
        # 2b. Enter left subtree
        insert_into_position(node, tree_node.left)
      end
    when 1
      # 3a. Sets right child if it is nil
      if tree_node.right.nil?
        node.parent = tree_node
        tree_node.right = node
      else
        # 3b. Enter right subtree
        insert_into_position(node, tree_node.right)
      end
    end
  end

  def remove_childless_node(node)
    if node == @root
      @root = nil
    else
      parent = node.parent
      parent.right && parent.right == node ? parent.right = nil : parent.left = nil
    end
  end

  def remove_one_child_node(node)
    child = node.left ? node.left : node.right
    # case when node is root
    if node == @root
      @root = child
    else
      parent = node.parent
      child.parent = child.parent.parent
      parent.right == node ? parent.right = child : parent.left = child
    end
  end

  def remove_two_child_node(node)
    # step 1 get left subtrees max
    max = maximum(node.left)
    # step 2 replace node with max
    # case 1 root
    if node == @root
      max.right = node.right
      max.left = node.left
    # case 2 with parent
    else
      delete(max.value)
      node.parent.right == node ? node.parent.right = max : node.parent.left = max
      max.right = node.right
      max.left = node.left
    end
  end



  def num_depth(depth, tree_node = @root)
    return unless tree_node
    return if tree_node.left.nil? && tree_node.right.nil?
    depth += 1

    if depth > @max_depth
      @max_depth = depth
    end

    num_depth(depth, tree_node.left)
    num_depth(depth, tree_node.right)

    @max_depth
  end

end
