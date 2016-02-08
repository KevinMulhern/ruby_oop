require 'player'

describe Player do
  subject(:player) { Player.new(name, symbol) }
  let(:name) { 'kevin' }
  let(:symbol) { 'x' }

  it 'initializes a new player' do
    expect(player).to be_an_instance_of(Player)
  end

  it 'sets the players name' do
    expect(player.name).to eql(name)
  end

  it 'sets the players symbol' do
    expect(player.symbol).to eql(symbol)
  end

  describe '#take_turn' do
    subject(:take_turn) { player.take_turn(player_1) }
    let(:player_1) { double('Player', name: 'kevin', symbol: 'x')}

    before do
      expect(player).to receive(:gets).and_return('2')
    end

    it 'returns the entered number' do
      expect(take_turn).to eql(1)
    end


  end

end