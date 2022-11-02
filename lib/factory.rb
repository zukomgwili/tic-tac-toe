require './lib/input_output'

class Factory
  def create_human_player(mark)
    HumanPlayer.new(mark, InputOutput.new)
  end

  def create_computer_player(mark)
    ComputerPlayer.new(mark)
  end
end
