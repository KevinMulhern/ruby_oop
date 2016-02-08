require_relative 'cell'

class Grid

  attr_accessor :cells

  def initialize(cells)
    @cells = cells
  end

  def self.create_grid(cells)
    new(cells).create_grid
  end

  def create_grid
    build_grid
  end

  private

  def build_grid
     "  #{cell_value(0)}  |  #{cell_value(1)}  |  #{cell_value(2)}\n" +
     "#{lower_divider}\n" +
     "  #{cell_value(3)}  |  #{cell_value(4)}  |  #{cell_value(5)}\n" +
     "#{lower_divider}\n" +
     "  #{cell_value(6)}  |  #{cell_value(7)}  |  #{cell_value(8)}\n"
  end

  def cell_value(index)
    cells[index].value
  end

  def lower_divider
    "-----" * 3
  end
end
