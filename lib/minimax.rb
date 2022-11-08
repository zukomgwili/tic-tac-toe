def minimax(nodes, is_maximizer, _max_depth, _depth, _node_index)
  depth = calculate_tree_height(nodes.length)
  if is_maximizer
    return nodes.max if nodes.length == 2

    if depth == 2
      chunks = nodes.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      return reduced.max
    end

    if depth == 3
      chunks = nodes.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      return reduced.max
    end

    if depth == 4
      chunks = nodes.each_slice(2).to_a
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
    return nodes.min if nodes.length == 2

    if depth == 2
      chunks = nodes.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      return reduced.min
    end

    if depth == 3
      chunks = nodes.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.min }
      chunks = reduced.each_slice(2).to_a
      reduced = chunks.reduce([]) { |acc, array| acc << array.max }
      return reduced.min
    end

    if depth == 4
      chunks = nodes.each_slice(2).to_a
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
