class GameLogic

  attr_accessor :game, :interface, :board
  def initialize(game, interface, board)
    @game = game
    @interface = interface
    @board = board
  end

  def game_tied_actions
		interface.display_game_tied_notification
		end_game_actions
	end

  def end_game_actions
		interface.show_Board
		game.play_again?
	end

  def game_won_actions(name)
    interface.display_game_won_notification(name)
    end_game_actions
  end

  def play_again_choices(choice)
		if choice == "y"
      create_new_game
		elsif choice == 'n'
			exit_game
		else
			interface.invalid_choice_notification
		end
	end

  def create_new_game
    game.create_new_game
  end

  def exit_game
    game.exit_game
  end

  def check_three_in_row(positions, symbol)
    board.three_positions_in_row?(positions, symbol)
  end

  def move_player_on_board(symbol)
		pos = game.get_position_from_player
    set_positions(pos, symbol)
	end

  def set_positions(pos, symbol)
    board.set_position(pos, symbol)
  end

  def end_of_game?(name)
    if game.current_player_won?
      game_won_actions(name)
    elsif board.all_positions_taken?
      game_tied_actions
    end
  end


end
