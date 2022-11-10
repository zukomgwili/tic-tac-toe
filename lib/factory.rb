require './lib/input_output'
require './lib/rules'

class Factory
  def create_human_player(mark)
    HumanPlayer.new(mark, InputOutput.new)
  end

  def create_computer_player(mark, opponent)
    ComputerPlayer.new(mark, opponent)
  end

  def create_rules
    Rules.new
  end
end
