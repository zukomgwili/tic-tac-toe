class Player
    attr_reader :mark
    
    def initialize(mark)
        @mark = mark
    end

    def pick(square,board)
        board.put(@mark,square)
    end
end