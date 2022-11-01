require 'board'

describe Board do
  it 'should create board with empty squares' do
    board = Board.new

    expect(board.board).to eq(['', '', '', '', '', '', '', '', ''])
  end

  describe 'put' do
    describe 'given a mark and a square' do
      it 'should place mark in square' do
        board = Board.new

        result = board.put('X', 1)

        expect(result).to eq(['X', '', '', '', '', '', '', '', ''])
      end

      describe 'when the square is not empty' do
        it 'should prevent placing of mark' do
          board = Board.new(['X', '', '', '', '', '', '', '', ''])

          result = board.put('O', 1)

          expect(result).to eq(['X', '', '', '', '', '', '', '', ''])
        end
      end

      describe 'when the square number is less than 1' do
        it 'should prevent should prevent placing of mark' do
          board = Board.new

          result = board.put('X', 0)

          expect(result).to eq(['', '', '', '', '', '', '', '', ''])
        end
      end

      describe 'when the square number is 9' do
        it 'should place mark in the square' do
          board = Board.new

          result = board.put('X', 9)

          expect(result).to eq(['', '', '', '', '', '', '', '', 'X'])
        end
      end

      describe 'when the square number is greater than 9' do
        it 'should prevent should prevent placing of mark' do
          board = Board.new

          result = board.put('X', 10)

          expect(result).to eq(['', '', '', '', '', '', '', '', ''])
        end
      end
    end
  end

  describe 'empty_squares?' do
    describe 'when there are empty squares' do
      it 'should return true' do
        board = Board.new

        expect(board.empty_squares?).to eq(true)
      end
    end
  end

  describe 'marks_at' do
    it 'should return marks at given locations' do
      board = Board.new(['O', '', 'X', 'O', 'X', 'X', 'O', '', ''])

      expect(board.marks_at(0, 3, 6)).to eq(%w[O O O])
    end
  end
end
