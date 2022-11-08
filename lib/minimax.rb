def minimax(scores, is_maximizer, max_depth, _depth, _node_index)
  return scores[_node_index] if _depth == max_depth

  depth = calculate_tree_height(scores.length)
  if is_maximizer
    return scores.max if scores.length == 2

    if depth == 2
      chunks = scores.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      return reduced.max
    end

    if depth == 3
      chunks = scores.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      return reduced.max
    end

    if depth == 4
      chunks = scores.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      reduced.max
    end
  else
    return scores.min if scores.length == 2

    if depth == 2
      chunks = scores.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      return reduced.min
    end

    if depth == 3
      chunks = scores.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      return reduced.min
    end

    if depth == 4
      chunks = scores.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      reduced.min
    end
  end
end

def calculate_tree_height(leaves_count)
  leaves_count == 1 ? 0 : 1 + calculate_tree_height(leaves_count / 2)
end
