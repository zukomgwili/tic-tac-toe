def minimax(leaves, is_maximizer)
  if is_maximizer
    leaves.max
  else
    leaves.min
  end
end
