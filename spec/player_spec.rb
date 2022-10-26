require "player"
require "board"

describe Player do
    describe "pick" do
        it "should mark square on the board" do
            board = Board.new
            player = Player.new("X")

            player.pick(1, board)

            expect(board.inspect).to eq(["X","","","","","","","",""])
        end
    end
end