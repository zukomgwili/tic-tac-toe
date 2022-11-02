class Rules
  def game_over?(board)
    !board.empty_squares? || a_winner?(board)
  end

  def a_winner?(board)
    winning_rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [6, 4, 2], [0, 4, 8]]
    winning_rows.each do |row|
      return true if winning_row?(board, *row)
    end
    false
  end

  def winning_row?(board, *args)
    row = board.marks_at(*args)
    row.all? { |mark| mark.strip.length == 1 } && row.uniq.length == 1
  end
end
