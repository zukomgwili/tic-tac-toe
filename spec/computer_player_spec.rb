require 'computer_player'
require 'board'

describe ComputerPlayer do
  describe 'pick' do
    describe 'when the board is empty' do
      it 'should pick a square to put a mark on' do
        player = ComputerPlayer.new('X')
        board = Board.new

        result = player.pick(board)

        expect(result).to be true
        expect(board.board).to eq(['X', '', '', '', '', '', '', '', ''])
      end
    end

    describe 'when the board is not empty' do
      it 'should pick the next available square' do
        player = ComputerPlayer.new('X')
        board = Board.new(['O', 'X', 'O', 'X', '', 'O', '', '', ''])

        result = player.pick(board)

        expect(result).to be true
        expect(board.board).to eq(['O', 'X', 'O', 'X', 'X', 'O', '', '', ''])
      end
    end
  end
end
