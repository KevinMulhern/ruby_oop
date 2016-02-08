require 'cell'

describe Cell do
  subject(:cell) { Cell.new() }

  describe '#cell' do

    context 'when cell has no value set' do

      it 'cell will have a default value of an empty string' do
        expect(cell.value).to eql("")
      end
    end

    context 'when cell has value set' do
      let(:value) { "x" }

      before do
        cell.value = value
      end

      it 'sets the value' do
        expect(cell.value).to eql(value)
      end
    end
  end

  describe '#cell_taken' do

    context 'when cell is not taken' do

      it 'will return false' do
        expect(cell.taken?).to eql(false)
      end
    end

    context 'when cell is taken' do
      let(:value) { "x" }

      before do
        cell.value = value
      end

      it 'will return true' do
        expect(cell.taken?).to eql(true)
      end
    end

  end
end