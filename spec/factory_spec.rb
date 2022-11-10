require 'factory'
require 'human_player'

describe Factory do
  describe 'create_human_player' do
    it 'should create human player' do
      factory = Factory.new

      result = factory.create_human_player('X')

      expect(result).to be_an_instance_of(HumanPlayer)
      expect(result).to be_a_kind_of(Player)
    end
  end

  describe 'create_computer_player' do
    it 'should create computer player' do
      factory = Factory.new

      result = factory.create_computer_player('O', 'X')

      expect(result).to be_an_instance_of(ComputerPlayer)
      expect(result).to be_a_kind_of(Player)
    end
  end
end
