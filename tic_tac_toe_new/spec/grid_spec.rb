require 'grid'

describe Grid do
  let(:grid) { Grid.new(cells)}
  let(:cells) {
    [
      cell,
      cell,
      cell,
      cell,
      cell,
      cell,
      cell,
      cell,
      cell,
    ]
  }
  let(:cell) { double('Cell')}

  before do
    allow(cell).to receive(:value).and_return("")
  end

  describe '#create_grid' do
    let(:expected_grid) {
       "  #{""}  |  #{""}  |  #{""}\n" +
       "#{'-----' * 3}\n" +
       "  #{""}  |  #{""}  |  #{""}\n" +
       "#{'-----' * 3}\n" +
      "  #{""}  |  #{""}  |  #{""}\n"
    }

    it 'creates a tic tac toe board' do
      expect(grid.create_grid).to eql(expected_grid)
    end

  end
end