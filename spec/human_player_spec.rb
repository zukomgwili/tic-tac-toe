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

      result = player.pick(board)

      expect(result).to be true
      expect(board.board).to eq(['X', '', '', '', '', '', '', '', ''])
    end

    describe 'when a pick is not successful' do
      it 'should return false' do
        $stdin = StringIO.new('1')
        player = HumanPlayer.new('X')
        board = Board.new(['X', '', '', '', '', '', '', '', ''])

        result = player.pick(board)

        expect(result).to be false
        expect(board.board).to eq(['X', '', '', '', '', '', '', '', ''])
      end
    end
  end
end
