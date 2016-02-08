require_relative 'player'

class Game

  attr_accessor :players, :board, :current_player

  def initialize(board)
    @board = board
  end

  def play
    create_players(2)
    loop do
      take_turn
      break if game_over?
      switch_players
    end
    end_of_game_actions
  end

  def players
    @players ||= []
  end

  private

  def take_turn
    clear_screen
    display_players
    display_board
    set_position_on_board
  end

  def end_of_game_actions
    clear_screen
    display_board
    display_message
  end

  def display_message
    if game_over? == "Winner"
      p "#{current_player.name} is the winner!"
    else
      p "It's a Draw!"
    end
  end

  def game_over?
    board.game_over?(current_player.symbol)
  end

  def clear_screen
    system('clear')
  end

  def set_position_on_board
    board.set_position(
      current_player_take_turn,
      current_player.symbol
    )
  end

  def display_players
    players.each do |player|
      puts "#{player.name} you are #{player.symbol}"
    end
  end

  def current_player_take_turn
    current_player.take_turn(current_player)
  end

  def current_player
    @current_player ||= players[0]
  end

  def switch_players
    @current_player = players.find { |player| player != current_player }
  end

  def display_board
    print board.create_board
  end

  def get_name(num)
    "Player #{num}"
  end

  def create_players(num)
    num.downto(1) do |num|
      players.unshift(Player.new(get_name(num), assign_symbol(num)))
    end
  end

  def assign_symbol(num)
    symbols.at(num -1)
  end

  def symbols
    ['x', 'o']
  end
end