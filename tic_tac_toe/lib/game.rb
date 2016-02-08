require_relative 'player'
require_relative 'board'
require_relative 'interface'
require_relative 'game_logic'

class Game

  attr_accessor :player1, :player2, :board, :current_player, :interface, :game_logic
  
  def initialize(board, player1, player2)
    @board = board
    @interface = create_new_interface
    clear_screen
    @player1 = player1
    @player2 = player2
    @current_player = player1
    @game_logic = new_game_logic
  end

  def play
    loop do
      show_board
      move_player_on_board
      clear_screen
      end_of_game?
      switch_to_other_player
    end
  end

  def end_of_game?
    game_logic.end_of_game?(current_player.name)
  end

  def show_board
    interface.show_Board
  end

  def move_player_on_board
    game_logic.move_player_on_board(current_player.symbol)
  end

  def switch_to_other_player
    @current_player = switch_current_player
  end

  def get_position_from_player
    position = ask_player_for_position
    return position if board.valid_position?(position)
    invalid_position_notification
    get_position_from_player
  end

  def ask_player_for_position
    interface.ask_player_for_position(current_player)
  end

  def invalid_position_notification
    interface.display_invalid_position_notification
  end

  def switch_current_player
    all_players.find { |player| player != current_player }
  end

  def play_again?
    while choice = interface.get_players_choice(current_player)
      play_again_choices(choice)
   end
 end

  def play_again_choices(choice)
    game_logic.play_again_choices(choice)
  end

  def exit_game
    exit
  end

  def create_new_game
    clear_last_game
    clear_screen
    play
  end

  def clear_last_game
    @board = create_new_board
    @interface = create_new_interface
    @game_logic = new_game_logic
  end

  def current_player_won?
    board.winning_moves.any? { |positions| check_three_in_row(positions) }
  end

  def check_three_in_row(positions)
    game_logic.check_three_in_row(positions, current_player.symbol)
  end

  private

  def clear_screen
    interface.clear_screen
  end

  def create_new_board
    Board.new
  end

  def all_players
    [@player1, @player2]
  end

  def new_game_logic
    GameLogic.new(self, interface, board)
  end

  def create_new_interface
    Interface.new(@board)
  end
end

tictactoe = Game.new(Board.new, Player.new, Player.new)
tictactoe.play
