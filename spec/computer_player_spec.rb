require 'computer_player'
require 'board'

describe ComputerPlayer do
  describe 'pick' do
    describe 'when the board is empty' do
      it 'should pick a square to put a mark on' do
        player = ComputerPlayer.new('X')
        board = Board.new

        result = player.pick(board)

        expect(result.board).to eq(['X', '', '', '', '', '', '', '', ''])
      end
    end

    describe 'when the board is not empty' do
      it 'should pick the next available square' do
        player = ComputerPlayer.new('X')
        board = Board.new(['O', 'X', 'O', 'X', '', 'O', '', '', ''])

        result = player.pick(board)

        expect(result.board).to eq(['O', 'X', 'O', 'X', 'X', 'O', '', '', ''])
      end
    end

    describe 'when the board is not empty' do
      describe 'and there are no more picks to be made' do
        it 'should stop attempting to make a pick' do
          player = ComputerPlayer.new('X')
          board = Board.new(%w[X O X X X O O X O])

          result = player.pick(board)

          expect(result.board).to eq(%w[X O X X X O O X O])
        end
      end
    end
  end
end
