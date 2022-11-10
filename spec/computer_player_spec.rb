require 'computer_player'
require 'board'

describe ComputerPlayer do
  describe 'pick' do
    describe 'when the board is empty' do
      it 'should pick a square to put a mark on' do
        player = ComputerPlayer.new('X')
        board = Board.new

        result = player.pick(board)

        expect(result).to eq(['X', '', '', '', '', '', '', '', ''])
      end
    end

    describe 'when the board is not empty' do
      it 'should pick the next available square' do
        player = ComputerPlayer.new('X')
        board = Board.new(['O', 'X', 'O', 'X', '', 'O', '', '', ''])

        result = player.pick(board)

        expect(result).to eq(['O', 'X', 'O', 'X', 'X', 'O', '', '', ''])
      end
    end

    describe 'when the board is not empty' do
      describe 'and there are no more picks to be made' do
        it 'should stop attempting to make a pick' do
          player = ComputerPlayer.new('X')
          board = Board.new(%w[X O X X X O O X O])

          result = player.pick(board)

          expect(result).to eq(%w[X O X X X O O X O])
        end
      end
    end
  end

  describe 'evaluate' do
    describe 'when the player has a winning top row' do
      it 'should return the value 1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['X', 'X', 'X', 'O', 'O', '', '', '', ''])

        expect(result).to eq(1)
      end
    end
    describe 'when the opponent has a winning top row' do
      it 'should return the value -1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['O', 'O', 'O', 'X', 'X', '', 'X', '', ''])

        expect(result).to eq(-1)
      end
    end
    describe 'when the player has a winning middle row' do
      it 'should return the value 1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['O', 'O', '', 'X', 'X', 'X', '', '', ''])

        expect(result).to eq(1)
      end
    end
    describe 'when the opponent has a winning middle row' do
      it 'should return the value -1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['', 'X', 'X', 'O', 'O', 'O', 'X', '', ''])

        expect(result).to eq(-1)
      end
    end
    describe 'when the player has a winning bottom row' do
      it 'should return the value 1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['', '', '', '', 'O', 'O', 'X', 'X', 'X'])

        expect(result).to eq(1)
      end
    end
    describe 'when the opponent has a winning bottom row' do
      it 'should return the value -1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['', 'X', 'X', 'X', '', '', 'O', 'O', 'O'])

        expect(result).to eq(-1)
      end
    end
    describe 'when the player has a winning left column' do
      it 'should return the value 1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['X', 'O', 'O', 'X', '', '', 'X', '', ''])

        expect(result).to eq(1)
      end
    end
    describe 'when the opponent has a winning left column' do
      it 'should return the value -1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['', 'X', 'X', 'X', '', '', 'O', 'O', 'O'])

        expect(result).to eq(-1)
      end
    end
    describe 'when the player has a winning middle column' do
      it 'should return the value 1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['O', 'X', 'O', 'O', 'X', '', '', 'X', ''])

        expect(result).to eq(1)
      end
    end
    describe 'when the opponent has a winning middle column' do
      it 'should return the value -1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['X', 'O', 'X', 'X', 'O', '', '', 'O', ''])

        expect(result).to eq(-1)
      end
    end
    describe 'when the player has a winning right column' do
      it 'should return the value 1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['O', '', 'X', 'O', '', 'X', '', '', 'X'])

        expect(result).to eq(1)
      end
    end
    describe 'when the opponent has a winning right column' do
      it 'should return the value -1' do
        player = ComputerPlayer.new('X')

        result = player.evaluate(['X', 'X', 'O', 'X', '', 'O', '', '', 'O'])

        expect(result).to eq(-1)
      end
    end
  end
end
