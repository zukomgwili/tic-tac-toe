require "game"
require "presenter"
require "computer_player"
require "player"
require "factory"

describe Game do
    presenter = nil
    board = nil
    game = nil
    factory = nil
    before do
        presenter = Presenter.new
        board = Board.new
        factory = Factory.new
        allow(presenter).to receive(:display_rules)
        allow(presenter).to receive(:display_board)
        allow(presenter).to receive(:update_board)
        allow(presenter).to receive(:alert)
        allow(presenter).to receive(:game_options)
        allow(factory).to receive(:create_board).and_return(board)
        allow(factory).to receive(:create_human_player).and_return(Player.new("X"), Player.new("O"))

        game = Game.new(presenter,factory)    
    end

    describe "start" do
        example "displays rules" do
            allow(presenter).to receive(:prompt).and_return(1,4,2,5,3)
            
            game.start()

            expect(presenter).to have_received(:display_rules).with(["Players take turns", "Mark empty squares", "Row(up/down,across,diagonally) with 3 same marks wins the game","Game is tied when all squares are filled but no winning row"])
        end

        example "displays board" do
            allow(presenter).to receive(:prompt).and_return(1,4,2,5,3)
            
            game.start()

            expect(presenter).to have_received(:display_board).with(board.board).once
        end

        example "issues game options" do
            allow(presenter).to receive(:prompt).and_return(1,4,2,5,3)
            
            game.start()

            expect(presenter).to have_received(:game_options).with(["Human vs Human", "Human vs Computer", "Computer vs Computer"]).once
        end

        describe "when the human vs computer game is selected" do
            example "have a human play against a computer" do
                computer_player = ComputerPlayer.new("X")
                human_player = Player.new("O")
                allow(computer_player).to receive(:pick).and_return(1,2,3)
                allow(presenter).to receive(:prompt).and_return(2,4,5)
                allow(factory).to receive(:create_computer_player).and_return(computer_player)
                allow(factory).to receive(:create_human_player).and_return(human_player)

                game.start()

                expect(board.board).to eq(["X","X","X","O","O","","","",""])
                expect(presenter).to have_received(:alert).with("Player X has won")
                    
            end
        end

        example "a game that results in a tie" do
            allow(presenter).to receive(:prompt).and_return(1,1,9,3,7,4,6,5,2,8)

            game.start()

            expect(board.board).to eq(["X","O","X","X","X","O","O","X","O"])
            expect(presenter).to have_received(:alert).with("It's a tie")
        end

        example "a game with a top-across winning row" do
            allow(presenter).to receive(:prompt).and_return(1,1,4,2,5,3)

            game.start()

            expect(board.board).to eq(["X","X","X","O","O","","","",""])
            expect(presenter).to have_received(:alert).with("Player X has won")
        end

        example "a game with a middle-across winning row " do
            allow(presenter).to receive(:prompt).and_return(1,1,4,7,5,3,6)

            game.start()

            expect(board.board).to eq(["X","","X","O","O","O","X","",""])
            expect(presenter).to have_received(:alert).with("Player O has won")
        end

        example "a game with a bottom-across winning row " do
            allow(presenter).to receive(:prompt).and_return(1,7,3,8,6,9,5)

            game.start()

            expect(board.board).to eq(["","","O","","","O","X","X","X"])
            expect(presenter).to have_received(:alert).with("Player X has won")
        end

        example "a game with a left-down winning row " do
            allow(presenter).to receive(:prompt).and_return(1,3,1,6,4,5,7)

            game.start()

            expect(board.board).to eq(["O","","X","O","X","X","O","",""])
            expect(presenter).to have_received(:alert).with("Player O has won")
        end

        example "a game with a middle-down winning row " do
            allow(presenter).to receive(:prompt).and_return(1,2,1,5,4,8)

            game.start()

            expect(board.board).to eq(["O","X","","O","X","","","X",""])
            expect(presenter).to have_received(:alert).with("Player X has won")
        end

        example "a game with a right-down winning row " do
            allow(presenter).to receive(:prompt).and_return(1,7,3,8,6,4,9)

            game.start()

            expect(board.board).to eq(["","","O","X","","O","X","X","O"])
            expect(presenter).to have_received(:alert).with("Player O has won")
        end

        example "a game with a top-left-bottom-right winning row " do
            allow(presenter).to receive(:prompt).and_return(1,7,4,5,1,3)

            game.start()

            expect(board.board).to eq(["O","","X","O","X","","X","",""])
            expect(presenter).to have_received(:alert).with("Player X has won")
        end

        describe "when a player has selected a square" do
            example "should update the presenter" do
                allow(presenter).to receive(:prompt).and_return(1,7)
    
                game.start()
    
                expect(presenter).to have_received(:update_board).with(["","","","","","","X","",""]).at_least(1)
            end            
        end
    end
end