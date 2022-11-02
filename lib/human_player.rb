require './lib/player'

class HumanPlayer < Player
  def initialize(mark, input)
    super(mark)
    @input = input
  end

  def pick(board)
    @input.out("Player #{@mark}, please make your selection")
    square = @input.in
    board.put(@mark, square)
  end
end
