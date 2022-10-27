class Board
  attr_reader :board

  def initialize(board = ['', '', '', '', '', '', '', '', ''])
    @board = board
  end

  def put(mark, square)
    location = square - 1
    square_is_not_empty = @board[location] != ''
    square_location_is_invalid = location.negative? || location > 8
    return if square_is_not_empty || square_location_is_invalid

    @board[location] = mark
  end

  def inspect
    @board
  end

  def empty_squares?
    @board.any? { |mark| mark.strip.length.zero? }
  end

  def marks_at(*args)
    @board.values_at(*args)
  end
end
