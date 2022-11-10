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
    if (board_snapshot[0] == board_snapshot[1] && board_snapshot[1] == board_snapshot[2] && board_snapshot[2] == @mark) ||
       (board_snapshot[3] == board_snapshot[4] && board_snapshot[4] == board_snapshot[5] && board_snapshot[5] == @mark)
      1
    else
      -1
    end
  end
end
