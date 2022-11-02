require 'human_player'
require 'board'
require 'input'

describe HumanPlayer do
  describe 'pick' do
    it 'prompts player for input' do
      input = Input.new
      allow(input).to receive(:in).and_return(1)
      allow(input).to receive(:out)

      player = HumanPlayer.new('X', input)
      board = Board.new

      player.pick(board)

      expect(input).to have_received(:out).with('Player X, please make your selection')
    end

    it 'should pick a square to put a mark on' do
      input = Input.new
      allow(input).to receive(:in).and_return(1)

      player = HumanPlayer.new('X', input)
      board = Board.new

      result = player.pick(board)

      expect(result).to eq(['X', '', '', '', '', '', '', '', ''])
    end
  end
end
