require 'board'
require 'cell'

describe Board do
  subject(:board) { Board.new(grid) }
  let(:cells) { Array.new(9) { Cell.new} }
  let(:grid) { double(Grid, cells: cells) }

  describe '#create_board' do

    let(:expected_board) {
       "  #{""}  |  #{""}  |  #{""}\n" +
       "#{'-----' * 3}\n" +
       "  #{""}  |  #{""}  |  #{""}\n" +
       "#{'-----' * 3}\n" +
      "  #{""}  |  #{""}  |  #{""}\n"
    }

    before do
      allow(grid).to receive(:create_grid).
        and_return(expected_board)
    end

    it 'creates a board' do
      expect(board.create_board).to eql(expected_board)
    end
  end

  describe '#cells' do

    it 'returns the cells' do
      expect(board.cells).to eql(cells)
    end
  end

  describe '#set_position' do
    subject(:set_position) { board.set_position(position, symbol) }
    let(:position) { 1 }
    let(:symbol) { 'x' }

    it 'sets the position with symbol' do
      cells[0].value = 'x'

      expect(set_position).to eql(symbol)
    end

    it 'populates the correct position with a symbol' do
      set_position
      expect(cells[position].value).to eql(symbol)
    end
  end

  describe '#game_over?' do
    subject(:game_over) { board.game_over?(symbol) }
    let(:symbol) { 'x' }

    context 'when game is won' do

      it 'returns winner when 3 in a row' do
        board.set_position(0, symbol)
        board.set_position(1, symbol)
        board.set_position(2, symbol)

        expect(game_over).to eql('Winner')
      end
    end


    context 'when game is a draw' do
      let(:symbol_x) { 'x' }
      let(:symbol_o) { 'o' }

      it 'returns draw when all cells are taken' do
        board.set_position(0, symbol_x)
        board.set_position(1, symbol_o)
        board.set_position(2, symbol_o)
        board.set_position(3, symbol_o)
        board.set_position(4, symbol_x)
        board.set_position(5, symbol_x)
        board.set_position(6, symbol_x)
        board.set_position(7, symbol_x)
        board.set_position(8, symbol_o)

        expect(board.game_over?(symbol_o)).to eql('Draw')
        expect(board.game_over?(symbol_x)).to eql('Draw')
      end
    end

    context 'when game is not won or drawn' do
      let(:symbol) { 'x' }


      it 'returns false' do
        expect(game_over).to eql(false)
      end
    end
  end

end