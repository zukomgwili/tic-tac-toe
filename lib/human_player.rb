require './lib/player'

class HumanPlayer < Player
  def initialize(mark, input)
    super(mark)
    @input = input
  end

  def pick(board)
    square = @input.get
    board.put(@mark, square)
  end
end
