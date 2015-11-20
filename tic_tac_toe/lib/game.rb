require_relative 'player'
require_relative 'board'
require_relative 'interface'
require_relative 'game_logic'

class Game

	attr_accessor :player1, :player2, :board, :current_player, :interface, :game_logic
	def initialize
		@board = create_new_board
		@interface = create_new_interface
		interface.clear_screen
		@player1 = create_new_player
		@player2 = create_new_player
		@current_player = player1
		@game_logic = new_game_logic
	end

	def create_new_player
		Player.new
	end

	def all_players
		[@player1, @player2]
	end

	def new_game_logic
		GameLogic.new(self, interface, board)
	end

	def create_new_interface
		Interface.new(board)
	end

	def create_new_board
		Board.new
	end

	def play
		loop do
			interface.show_Board
			game_logic.move_player_on_board(current_player.symbol)
			interface.clear_screen
			game_logic.end_of_game?(current_player.name)
			switch_to_other_player
		end
	end

	def switch_to_other_player
		@current_player = switch_current_player
	end

	def get_position_from_player
		position = interface.ask_player_for_position(current_player)
		return position if board.valid_position?(position)
		interface.display_invalid_position_notification
		get_position_from_player
	end

	def switch_current_player
		all_players.find { |player| player != current_player }
	end

	def play_again?
		while choice = interface.get_players_choice(current_player)
			game_logic.play_again_choices(choice)
		end
	end

	def exit_game
		exit
	end

	def create_new_game
		@board = create_new_board
		interface.clear_screen
		play
	end

	def current_player_won?
		board.winning_moves.any? { |positions| game_logic.check_three_in_row(positions, current_player.symbol) }
	end
end

tictactoe = Game.new
tictactoe.play
