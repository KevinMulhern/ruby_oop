require_relative 'game'
require_relative 'board'
require_relative 'grid'
require_relative 'cell'

cells = Array.new(9) { Cell.new }
board = Board.new(Grid.new(cells))

game = Game.new(board)
game.play