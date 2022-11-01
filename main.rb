#!/usr/bin/env ruby
require './lib/presenter'
require './lib/board'
require './lib/player'
require './lib/factory'
require './lib/game'

def main
  presenter = Presenter.new
  board = Board.new
  factory = Factory.new

  game = Game.new(presenter, board, factory)

  game.start
end

main if $PROGRAM_NAME == __FILE__
