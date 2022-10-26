require "computer_player"
require "board"

describe ComputerPlayer do
    describe "pick" do
        it "should pick a square to put a mark on" do
            player = ComputerPlayer.new("X")

            result = player.pick(Board.new)

            expect(result).to eq(1)
        end
    end
end