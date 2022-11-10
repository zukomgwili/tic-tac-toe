require './lib/player'

class ComputerPlayer < Player
  def initialize(mark)
    super(mark)
    @square_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def pick(board)
    previous = board.board.clone
    square_number = @square_numbers.shift
    current = board.put(@mark, square_number)
    successful_pick = current != previous
    until successful_pick || @square_numbers.empty?
      square_number = @square_numbers.shift
      current = board.put(@mark, square_number)
      successful_pick = current != previous
    end
    current
  end

  def evaluate(board_snapshot)
    winning_rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [6, 4, 2], [0, 4, 8]]
    winning_rows.each do |row|
      return 1 if winning_row?(board_snapshot, *row) && player_winner?(board_snapshot, *row)
      return -1 if winning_row?(board_snapshot, *row) && !player_winner?(board_snapshot, *row)
    end
    0
  end

  def winning_row?(board_snapshot, *args)
    row = board_snapshot.values_at(*args)
    row.all? { |mark| mark.strip.length == 1 } && row.uniq.length == 1
  end

  def calc_move(board_snapshot, is_maximizer)
    value = evaluate(board_snapshot)
    return value if [-1, 1].include?(value)

    return 0 if board_snapshot.all? { |square| square.strip.length.zero? == false }

    if is_maximizer
      best_value = -1000
      board_snapshot.each_with_index do |square, index|
        next unless square.empty?

        board_snapshot[index] = @mark
        best_value = [best_value, calc_move(board_snapshot, false)].max
        board_snapshot[index] = ''
      end
    else
      best_value = 1000
      board_snapshot.each_with_index do |square, index|
        next unless square.empty?

        board_snapshot[index] = 'O'
        best_value = [best_value, calc_move(board_snapshot, true)].min
        board_snapshot[index] = ''
      end
    end
    best_value
  end

  def find_best_move(board_snapshot)
    best_move_value = -1000
    best_move = nil
    board_snapshot.each_with_index do |square, index|
      next unless square.empty?

      board_snapshot[index] = @mark
      move_value = calc_move(board_snapshot, false)
      board_snapshot[index] = ''
      best_move = index if move_value > best_move_value
    end
    best_move
  end

  private

  def player_winner?(board_snapshot, *row)
    board_snapshot.values_at(*row).include?(@mark)
  end
end
