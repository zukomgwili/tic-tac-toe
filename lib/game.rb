require './lib/player'
require './lib/computer_player'
require './lib/human_player'

class Game
  attr_reader :rules, :first_player, :second_player

  MAX_MOVE_COUNT = 9

  def initialize(presenter, board, factory)
    @presenter = presenter
    @board = board
    @factory = factory
    @options = ['Exit', 'Human vs Human', 'Human vs Computer', 'Computer vs Computer', 'Computer vs Human']
    @rules = ['Players take turns', 'Mark empty squares',
              'Row(up/down,across,diagonally) with 3 same marks wins the game',
              'Game is tied when all squares are filled but no winning row']
  end

  def start__X
    setup_game
    game_option = @presenter.prompt
    case game_option
    when 0
      return @presenter.alert('Game exited!')
    when 1
      @first_player = Player.new('X')
      @second_player = Player.new('O')
    when 2
      @first_player = Player.new('X')
      @second_player = ComputerPlayer.new('O')
    end
    player = @first_player
    we_have_a_winner = false
    while @board.empty_squares? && !a_winner?
      square = pick_square(player)
      mark_placed = @board.put(player.mark, square)
      @presenter.update_board(@board.board)
      we_have_a_winner = a_winner?
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

  def start
    setup_game
    game_option = @presenter.prompt
    case game_option
    when 0
      return @presenter.alert('Game exited!')
    when 1
      @first_player = @factory.create_human_player('X')
      @second_player = @factory.create_human_player('O')
    when 2
      @first_player = @factory.create_human_player('X')
      @second_player = @factory.create_computer_player('O')
    end
    player = @first_player
    we_have_a_winner = false
    while @board.empty_squares? && !a_winner?
      previous_board_snapshot = @board.snapshot
      board_snapshot = player.pick(@board)
      mark_placed = board_snapshot != previous_board_snapshot
      @presenter.update_board(@board.board)
      we_have_a_winner = a_winner?
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

  def a_winner?
    winning_rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [6, 4, 2], [0, 4, 8]]
    winning_rows.each do |row|
      return true if winning_row?(*row)
    end
    false
  end

  def winning_row?(*args)
    row = @board.marks_at(*args)
    row.all? { |mark| mark.strip.length == 1 } && row.uniq.length == 1
  end
end
