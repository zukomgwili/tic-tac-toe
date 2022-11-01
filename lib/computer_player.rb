require './lib/player'

class ComputerPlayer < Player
  def initialize(mark)
    super(mark)
    @square_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def pick(board)
    square_number = @square_numbers.shift
    successful_pick = board.put(@mark, square_number)
    until successful_pick || @square_numbers.empty?
      square_number = @square_numbers.shift
      successful_pick = board.put(@mark, square_number)
    end
    board
  end
end
