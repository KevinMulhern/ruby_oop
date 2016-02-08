require 'game'

describe Game do
  subject(:game) { Game.new(board) }
  let(:board) { double('Board', game_over?: game_status) }
  let(:position) { 2 }
  let(:game_status) { 'Winner' }
  let(:symbol) { 'x' }
  let(:expected_board) {
     "  #{""}  |  #{""}  |  #{""}\n" +
     "#{'-----' * 3}\n" +
     "  #{""}  |  #{""}  |  #{""}\n" +
     "#{'-----' * 3}\n" +
    "  #{""}  |  #{""}  |  #{""}\n"
  }
  let(:current_player) { players[0] }
  let(:players) {
    [
      Player.new('Player 1', 'x'),
      Player.new('Player 2', 'o')
    ]
  }

  before do
    allow(board).to receive(:create_board).
      and_return(expected_board)
    allow(board).to receive(:set_position).
      with(position, symbol )
    allow(current_player).to receive(:take_turn).
      with(current_player).and_return(position)
    allow(game).to receive(:current_player).
      and_return(current_player)
    allow(game).to receive(:game_over?).and_return(false)
  end

  describe '#new' do

    it 'initializes a new instance' do
      expect(Game.new(board)).to be_an_instance_of(Game)
    end
  end

  describe '#play' do
    subject(:play_game) { game.play }


    before do
      allow(game).to receive(:loop).and_yield
    end

    it 'Creates players' do
      expect(game).to receive(:create_players).with(2)
      subject
    end

    it 'goes through player turn actions' do
      expect(game).to receive(:take_turn)

      subject
    end


    context 'End game scenarios' do

      context 'when the game is won' do
         before do
           allow(game).to receive(:game_over?).and_return(game_status)
         end

        it 'returns the winning message' do
          expect(game.play).to eql("Player 1 is the winner!")
        end
      end


      context 'when the game is a draw' do
        let(:game_status) { 'Draw' }

        it 'returns the draw message' do
          expect(subject).to eql('It\'s a Draw!')
        end
      end
    end

    it 'switches the players' do
      expect(game).to receive(:switch_players)
      subject
    end
  end

  describe '#players' do
    subject(:play_game) { game.play }
    let(:num) { 2 }
    let(:symbols) { ['x', 'o'] }

    before do
      allow(game).to receive(:create_players).and_return(players)
      allow(game).to receive(:loop).and_yield
    end

    it 'contains the correct number of players' do
      expect(players.length).to eql(num)
    end

    it 'assigns the correct name to a player' do
      play_game

      expect(players[0].name).to eql('Player 1')
      expect(players[1].name).to eql('Player 2')
    end

    it 'assigns a symbol to each player' do
      play_game

      expect(players[0].symbol).to eql('x')
      expect(players[1].symbol).to eql('o')
    end
  end
end