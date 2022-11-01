class HumanPlayer < Player
  def pick(board)
    square = gets.chomp.strip.to_i
    board.put(@mark, square)
  end
end
