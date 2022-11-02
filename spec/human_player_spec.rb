require 'human_player'
require 'board'
require 'input'

describe HumanPlayer do
  describe 'pick' do
    it 'should pick a square to put a mark on' do
      input = Input.new
      allow(input).to receive(:get).and_return(1)

      player = HumanPlayer.new('X', input)
      board = Board.new

      result = player.pick(board)

      expect(result).to eq(['X', '', '', '', '', '', '', '', ''])
    end
  end
end
