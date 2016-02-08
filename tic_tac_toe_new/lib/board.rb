require_relative 'grid'

class Board

  attr_accessor :grid, :cells

  def initialize(grid)
    @grid = grid
  end

  def create_board
    grid.create_grid
  end

  def cells
    grid.cells
  end

  def set_position(position, value)
    cells[position].value = value
  end

  def game_over?(symbol)
    return "Winner" if winner?(symbol)
    return "Draw" if draw?
    false
  end

  private

  def winner?(symbol)
    winning_moves.any? { |winning_move| all_cells_match?(winning_move, symbol) }
  end

  def all_cells_match?(winning_move, symbol)
    winning_move.all? { |position|  cell_equal_symbol?(position, symbol) }
  end

  def cell_equal_symbol?(position, symbol)
    cells[position].value == symbol
  end

  def draw?
    cells.all? { |cell| cell.taken? }
  end

  def winning_moves
    [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6 ]]
  end
end
