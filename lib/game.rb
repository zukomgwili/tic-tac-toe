class Game
  attr_reader :rules, :first_player, :second_player

  MAX_MOVE_COUNT = 9

  def initialize(presenter, factory)
    @presenter = presenter
    @factory = factory
    @board = @factory.create_board
    @options = ['Human vs Human', 'Human vs Computer', 'Computer vs Computer']
    @rules = ['Players take turns', 'Mark empty squares',
              'Row(up/down,across,diagonally) with 3 same marks wins the game',
              'Game is tied when all squares are filled but no winning row']
  end

  def start
    setup_game
    setup_players
    next_player = @first_player
    number_of_moves = 1
    we_have_a_winner = false
    while number_of_moves <= MAX_MOVE_COUNT
      square = pick_square(next_player)
      @board.put(next_player.mark, square)
      @presenter.update_board(@board.board)
      number_of_moves += 1
      we_have_a_winner = a_winner?
      break if we_have_a_winner

      next_player = next_player == @first_player ? @second_player : @first_player
    end

    if we_have_a_winner
      @presenter.alert("Player #{next_player.mark} has won")
    else
      @presenter.alert("It's a tie")
    end
  end

  private

  def pick_square(next_player)
    square_number = 0
    if next_player.respond_to?(:pick)
      square_number = next_player.pick(@board.board)
    else
      @presenter.alert("Player #{next_player.mark}, please make your selection")
      square_number = @presenter.prompt
    end
    square_number
  end

  def setup_game
    @presenter.display_rules(@rules)
    @presenter.display_board(@board.board)
    @presenter.game_options(@options)
  end

  def setup_players
    game_option = @presenter.prompt
    case game_option
    when 1
      @first_player = @factory.create_human_player('X')
      @second_player = @factory.create_human_player('O')
    when 2
      @first_player = @factory.create_computer_player('X')
      @second_player = @factory.create_human_player('O')
    end
  end

  def a_winner?
    winning_row?(0, 1, 2) ||
      winning_row?(3, 4, 5) ||
      winning_row?(6, 7, 8) ||
      winning_row?(0, 3, 6) ||
      winning_row?(1, 4, 7) ||
      winning_row?(2, 5, 8) ||
      winning_row?(6, 4, 2)
  end

  def winning_row?(*args)
    row = @board.marks_at(*args)
    row.all? { |mark| mark.strip.length == 1 } && row.uniq.length === 1
  end
end
