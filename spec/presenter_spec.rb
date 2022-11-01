require 'presenter'
require 'stringio'

describe Presenter do
  after do
    $stdin = STDIN
  end

  describe 'prompt' do
    it 'should remove trailing spaces from input' do
      presenter = Presenter.new
      $stdin = StringIO.new('1 ')

      result = presenter.prompt

      expect(result).to eq(1)
    end
  end

  describe 'alert' do
    it 'should write to the console' do
      presenter = Presenter.new

      expect do
        presenter.alert('Player 1, you have won!')
      end.to output("Player 1, you have won!\n").to_stdout
    end
  end

  describe 'display_board' do
    it 'should draw board' do
      presenter = Presenter.new

      expect do
        presenter.display_board(['', '', '', '', '', '', '', '', ''])
      end.to output(" -----------\n|   |   |   |\n -----------\n|   |   |   |\n -----------\n|   |   |   |\n -----------\n").to_stdout
    end

    describe 'given a board with marks' do
      it 'should draw board' do
        presenter = Presenter.new

        expect do
          presenter.display_board(%w[X O X X X O O X O])
        end.to output(" -----------\n| X | O | X |\n -----------\n| X | X | O |\n -----------\n| O | X | O |\n -----------\n").to_stdout
      end
    end
  end

  describe 'update_board' do
    it 'should redraw board' do
      presenter = Presenter.new

      expect do
        presenter.update_board(%w[X O X X X O O X O])
      end.to output(" -----------\n| X | O | X |\n -----------\n| X | X | O |\n -----------\n| O | X | O |\n -----------\n").to_stdout
    end
  end

  describe 'display_rules' do
    it 'should display game rules' do
      presenter = Presenter.new

      expect do
        presenter.display_rules(['Players take turns', 'Mark empty squares',
                                 'Row(up/down,across,diagonally) with 3 same marks wins the game', 'Game is tied when all squares are filled but no winning row'])
      end.to output("RULES\n1. Players take turns.\n2. Mark empty squares.\n3. Row(up/down,across,diagonally) with 3 same marks wins the game.\n4. Game is tied when all squares are filled but no winning row.\n\n").to_stdout
    end
  end

  describe 'game_options' do
    it 'should display game options' do
      presenter = Presenter.new

      expect do
        presenter.game_options(['Exit', 'Human vs Human', 'Human vs Computer', 'Computer vs Computer'])
      end.to output("OPTIONS\n0. Exit\n1. Human vs Human\n2. Human vs Computer\n3. Computer vs Computer\n\nPlease select an option:\n").to_stdout
    end
  end
end
