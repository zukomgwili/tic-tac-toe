def minimax(scores, is_maximizer, max_depth, depth, node_index)
  return scores[node_index] if depth == max_depth

  if is_maximizer
    [minimax(scores, false, max_depth, depth + 1, node_index * 2),
     minimax(scores, false, max_depth, depth + 1, (node_index * 2) + 1)].max
  else
    [minimax(scores, true, max_depth, depth + 1, node_index * 2),
     minimax(scores, true, max_depth, depth + 1, (node_index * 2) + 1)].min
  end
end

def calculate_tree_height(leaves_count)
  leaves_count == 1 ? 0 : 1 + calculate_tree_height(leaves_count / 2)
end
