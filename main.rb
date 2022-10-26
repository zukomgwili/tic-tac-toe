#!/usr/bin/env ruby
require "./lib/presenter"
require "./lib/board"
require "./lib/player"
require "./lib/game"

def main
    presenter = Presenter.new
    board = Board.new

    game = Game.new(presenter,board)

    game.start()
end

main