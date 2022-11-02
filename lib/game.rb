require './lib/player'
require './lib/computer_player'
require './lib/human_player'

class Game
  attr_reader :rules, :first_player, :second_player

  def initialize(presenter, board, factory)
    @presenter = presenter
    @board = board
    @factory = factory
    @rules = factory.create_rules
  end

  def start
    setup_game
    game_option = @presenter.prompt
    return @presenter.alert('Game exited!') if game_option.zero?

    @first_player, @second_player = create_players(game_option)
    player = @first_player
    we_have_a_winner = false
    until @rules.game_over?(@board)
      previous_board_snapshot = @board.snapshot
      board_snapshot = player.pick(@board)
      mark_placed = board_snapshot != previous_board_snapshot
      @presenter.update_board(@board.board)
      we_have_a_winner = @rules.a_winner?(@board)
      break if we_have_a_winner

      if mark_placed
        player = player == @first_player ? @second_player : @first_player
      end
    end

    if we_have_a_winner
      @presenter.alert("Player #{player.mark} has won")
    else
      @presenter.alert("It's a tie")
    end
  end

  private

  def setup_game
    @presenter.display_rules(['Players take turns', 'Mark empty squares',
                              'Row(up/down,across,diagonally) with 3 same marks wins the game',
                              'Game is tied when all squares are filled but no winning row'])
    @presenter.display_board(@board.board)
    @presenter.game_options(['Exit', 'Human vs Human', 'Human vs Computer', 'Computer vs Computer',
                             'Computer vs Human'])
  end

  def create_players(game_type)
    case game_type
    when 1
      [@factory.create_human_player('X'), @factory.create_human_player('O')]
    when 2
      [@factory.create_human_player('X'), @factory.create_computer_player('O')]
    when 4
      [@factory.create_computer_player('O'), @factory.create_human_player('X')]
    end
  end
end
