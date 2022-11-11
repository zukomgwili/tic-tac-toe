require './lib/player'

class ComputerPlayer < Player
  def initialize(mark, opponent)
    super(mark)
    @opponent = opponent
  end

  def pick(board)
    return board.board unless board.empty_squares?

    previous = board.board.clone
    square_number = find_best_move(previous)
    current = board.put(@mark, square_number)
    successful_pick = current != previous
    until successful_pick || !board.empty_squares?
      square_number = find_best_move(previous)
      current = board.put(@mark, square_number)
      successful_pick = current != previous
    end
    current
  end

  def evaluate(board_snapshot)
    winning_rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [6, 4, 2], [0, 4, 8]]
    winning_rows.each do |row|
      return 10 if winning_row?(board_snapshot, *row) && player_winner?(board_snapshot, *row)
      return -10 if winning_row?(board_snapshot, *row) && !player_winner?(board_snapshot, *row)
    end
    0
  end

  def winning_row?(board_snapshot, *args)
    row = board_snapshot.values_at(*args)
    row.all? { |mark| mark.strip.length == 1 } && row.uniq.length == 1
  end

  def calc_move(board_snapshot, is_maximizer, depth)
    value = evaluate(board_snapshot)
    return value - depth if value == 10
    return value + depth if value == -10

    return 0 if board_snapshot.all? { |square| square.strip.length.zero? == false }

    empty_square_index = board_snapshot.index { |square| square.strip.length.zero? }
    best_value = is_maximizer ? -1000 : 1000
    if is_maximizer
      board_snapshot[empty_square_index] = @mark
      best_value = [best_value, calc_move(board_snapshot, false, depth + 1)].max
    else
      board_snapshot[empty_square_index] = @opponent
      best_value = [best_value, calc_move(board_snapshot, true, depth + 1)].min
    end
    board_snapshot[empty_square_index] = ''
    best_value
  end

  def find_best_move(board_snapshot)
    best_move_value = -1000
    best_move = nil
    board_snapshot.each_with_index do |square, empty_square_index|
      next unless square.empty?

      board_snapshot[empty_square_index] = @mark
      move_value = calc_move(board_snapshot, false, 0)
      board_snapshot[empty_square_index] = ''
      if move_value > best_move_value
        best_move_value = move_value
        best_move = empty_square_index + 1
      end
    end
    best_move
  end

  private

  def player_winner?(board_snapshot, *row)
    board_snapshot.values_at(*row).include?(@mark)
  end
end
