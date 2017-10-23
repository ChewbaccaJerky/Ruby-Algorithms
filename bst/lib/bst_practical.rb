require_relative "binary_search_tree"
def kth_largest(tree_node, k)
  return k = k -1 unless tree_node
  return tree_node if k == 0
  # puts tree_node.value
  kth_largest(tree_node.right, k)
  kth_largest(tree_node.left, k)
  tree_node
end
