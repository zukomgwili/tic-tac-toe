require 'human_player'
require 'board'
require 'input_output'

describe HumanPlayer do
  describe 'pick' do
    it 'prompts player for io' do
      io = InputOutput.new
      allow(io).to receive(:in).and_return(1)
      allow(io).to receive(:out)

      player = HumanPlayer.new('X', io)
      board = Board.new

      player.pick(board)

      expect(io).to have_received(:out).with('Player X, please make your selection')
    end

    it 'should pick a square to put a mark on' do
      io = InputOutput.new
      allow(io).to receive(:in).and_return(1)

      player = HumanPlayer.new('X', io)
      board = Board.new

      result = player.pick(board)

      expect(result).to eq(['X', '', '', '', '', '', '', '', ''])
    end
  end
end
