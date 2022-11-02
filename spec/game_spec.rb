require 'game'

describe Game do
  presenter = nil
  board = nil
  game = nil
  input = nil

  before do
    presenter = Presenter.new
    board = Board.new
    factory = Factory.new
    input = Input.new

    allow(factory).to receive(:create_human_player).and_return(HumanPlayer.new('X', input), HumanPlayer.new('O', input))
    allow(factory).to receive(:create_computer_player).and_return(ComputerPlayer.new('X'))

    allow(presenter).to receive(:display_rules)
    allow(presenter).to receive(:display_board)
    allow(presenter).to receive(:update_board)
    allow(presenter).to receive(:alert)
    allow(presenter).to receive(:game_options)

    game = Game.new(presenter, board, factory)
  end

  describe 'start' do
    example 'displays rules' do
      allow(presenter).to receive(:prompt).and_return(0)

      game.start

      expect(presenter).to have_received(:display_rules).with(['Players take turns', 'Mark empty squares',
                                                               'Row(up/down,across,diagonally) with 3 same marks wins the game', 'Game is tied when all squares are filled but no winning row'])
    end

    example 'displays board' do
      allow(presenter).to receive(:prompt).and_return(0)

      game.start

      expect(presenter).to have_received(:display_board).with(board.board).once
    end

    example 'issues game options' do
      allow(presenter).to receive(:prompt).and_return(0)

      game.start

      expect(presenter).to have_received(:game_options).with(['Exit', 'Human vs Human', 'Human vs Computer',
                                                              'Computer vs Computer', 'Computer vs Human']).once
    end

    describe 'when the first input is zero' do
      it 'should end the game' do
        allow(presenter).to receive(:prompt).and_return(0)

        game.start

        expect(presenter).to have_received(:alert).with('Game exited!')
      end
    end

    example 'a game that results in a tie' do
      allow(input).to receive(:get).and_return(1, 9, 3, 7, 4, 6, 5, 2, 8)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(%w[X O X X X O O X O])
      expect(presenter).to have_received(:alert).with("It's a tie")
    end

    example 'a game with a top-across winning row' do
      allow(input).to receive(:get).and_return(1, 4, 2, 5, 3)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['X', 'X', 'X', 'O', 'O', '', '', '', ''])
      expect(presenter).to have_received(:alert).with('Player X has won')
    end

    example 'a game with a middle-across winning row ' do
      allow(input).to receive(:get).and_return(1, 4, 7, 5, 3, 6)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['X', '', 'X', 'O', 'O', 'O', 'X', '', ''])
      expect(presenter).to have_received(:alert).with('Player O has won')
    end

    example 'a game with a bottom-across winning row ' do
      allow(input).to receive(:get).and_return(7, 3, 8, 6, 9, 5)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['', '', 'O', '', '', 'O', 'X', 'X', 'X'])
      expect(presenter).to have_received(:alert).with('Player X has won')
    end

    example 'a game with a left-down winning row ' do
      allow(input).to receive(:get).and_return(3, 1, 6, 4, 5, 7)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['O', '', 'X', 'O', 'X', 'X', 'O', '', ''])
      expect(presenter).to have_received(:alert).with('Player O has won')
    end

    example 'a game with a middle-down winning row ' do
      allow(input).to receive(:get).and_return(2, 1, 5, 4, 8)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['O', 'X', '', 'O', 'X', '', '', 'X', ''])
      expect(presenter).to have_received(:alert).with('Player X has won')
    end

    example 'a game with a right-down winning row ' do
      allow(input).to receive(:get).and_return(7, 3, 8, 6, 4, 9)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['', '', 'O', 'X', '', 'O', 'X', 'X', 'O'])
      expect(presenter).to have_received(:alert).with('Player O has won')
    end

    example 'a game with a bottom-left-top-right winning row ' do
      allow(input).to receive(:get).and_return(7, 4, 5, 1, 3)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['O', '', 'X', 'O', 'X', '', 'X', '', ''])
      expect(presenter).to have_received(:alert).with('Player X has won')
    end

    example 'a game with a top-left-bottom-right winning row ' do
      allow(input).to receive(:get).and_return(7, 1, 4, 5, 3, 9)
      allow(presenter).to receive(:prompt).and_return(1)

      game.start

      expect(board.board).to eq(['O', '', 'X', 'X', 'O', '', 'X', '', 'O'])
      expect(presenter).to have_received(:alert).with('Player O has won')
    end

    describe 'when a player attempts to mark an already marked square' do
      example 'the player should be given another attempt' do
        allow(input).to receive(:get).and_return(7, 7, 1, 4, 5, 3, 9)

        allow(presenter).to receive(:prompt).and_return(1)

        game.start

        expect(board.board).to eq(['O', '', 'X', 'X', 'O', '', 'X', '', 'O'])
        expect(presenter).to have_received(:alert).with('Player O has won')
      end

      example 'the player should be given an infinite number of attempts' do
        allow(input).to receive(:get).and_return(1, 9, 3, 7, 4, 6, 5, 2, 2, 2, 8)
        allow(presenter).to receive(:prompt).and_return(1)

        game.start

        expect(board.board).to eq(%w[X O X X X O O X O])
        expect(presenter).to have_received(:alert).with("It's a tie")
      end
    end

    describe 'when a player has selected a square' do
      example 'should update the presenter' do
        allow(input).to receive(:get).and_return(1, 9, 3, 7, 4, 6, 5, 2, 8)
        allow(presenter).to receive(:prompt).and_return(1)

        game.start

        expect(presenter).to have_received(:update_board)
          .with(%w[X O X X X O O X O]).at_least(1)
      end
    end
  end
end
