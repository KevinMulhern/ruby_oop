class Board
  attr_accessor :positions

  def initialize
    @positions = new_board
  end

  def new_board
    [" "] * 9
  end

  def winning_moves
		[[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,6], [0,4,8], [2,4,6]]
	end

  def valid_position?(pos)
		pos >= 0 && pos <= 8 && positions[pos] == " "
	end

  def set_position(position, symbol)
    positions[position] = symbol
	end

  def all_positions_taken?
    !positions.include?(" ")
  end

  def three_positions_in_row?(three_positions, symbol)
    three_positions.all? {|pos| positions[pos] == symbol }
  end
end
