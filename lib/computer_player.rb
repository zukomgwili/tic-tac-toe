require 'player'

class ComputerPlayer < Player
  def pick(board)
    board.put(@mark, 1)
  end
end
