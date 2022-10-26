class Game
    attr_reader :rules
    MAX_MOVE_COUNT = 9

    def initialize(presenter,board)
        @presenter = presenter
        @board = board
        @player_1 = Player.new("X")
        @player_2 = Player.new("O")
    end

    def start
        @presenter.display_rules(["Players take turns", "Mark empty squares", "Row(up/down,across,diagonally) with 3 same marks wins the game","Game is tied when all squares are filled but no winning row"])
        @presenter.display_board(@board.board)
        next_player = @player_1
        number_of_moves = 1
        we_have_a_winner = false
        while number_of_moves <= MAX_MOVE_COUNT
            @presenter.alert("Player #{next_player.mark}, please make your selection")
            input = @presenter.prompt
            @board.put(next_player.mark, input)
            @presenter.update_board(@board.board)
            number_of_moves += 1
            we_have_a_winner = have_a_winner?
            break if we_have_a_winner
            next_player = next_player == @player_1 ? @player_2 : @player_1
        end

        if we_have_a_winner
            @presenter.alert("Player #{next_player.mark} has won")
        else
            @presenter.alert("It's a tie")
        end
    end

    private
    
    def have_a_winner?
        winning_row?(0,1,2) ||
        winning_row?(3,4,5) ||
        winning_row?(6,7,8) ||
        winning_row?(0,3,6) ||
        winning_row?(1,4,7) ||
        winning_row?(2,5,8) ||
        winning_row?(6,4,2)
    end

    def winning_row?(*args)
        row = @board.marks_at(*args)
        row.all?{ |mark| mark.strip.length == 1 } && row.uniq.length === 1
    end
end