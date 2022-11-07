def minimax(leaves, is_maximizer)
  if is_maximizer
    return leaves.max if leaves.length == 2

    chunks = leaves.each_slice(2).to_a
    reduced = chunks.reduce([]) { |acc, array| acc << array.min }
    return reduced.max if reduced.length == 2
  else
    return leaves.min if leaves.length == 2

    chunks = leaves.each_slice(2).to_a
    reduced = chunks.reduce([]) { |acc, array| acc << array.max }
    return reduced.min if reduced.length == 2
  end
end
