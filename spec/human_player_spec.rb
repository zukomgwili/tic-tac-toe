require 'human_player'
require 'board'

describe HumanPlayer do
  after do
    $stdin = STDIN
  end

  describe 'pick' do
    it 'should pick a square to put a mark on' do
      $stdin = StringIO.new('1')
      player = HumanPlayer.new('X')
      board = Board.new
      allow(board).to receive(:put).and_return(['X', '', '', '', '', '', '', '', ''])

      result = player.pick(board)

      expect(result).to eq(['X', '', '', '', '', '', '', '', ''])
    end
  end
end
