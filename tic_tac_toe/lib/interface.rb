class Interface
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def show_Board
    puts "\n\n"
    puts "\t   #{board.positions[0]} |  #{board.positions[1]} |  #{board.positions[2]} "
    puts "\t ----|----|---- "
    puts "\t   #{board.positions[3]} |  #{board.positions[4]} |  #{board.positions[5]} "
    puts "\t ----|----|---- "
    puts "\t   #{board.positions[6]} |  #{board.positions[7]} |  #{board.positions[8]} "
    puts "\n\n "
  end

	def clear_screen
		system 'clear'
	end

  def display_game_tied_notification
    puts "It's A tie!"
  end

  def display_game_won_notification(name)
    puts "#{name} has won!"
  end

  def ask_player_for_position(player)
    print "Choose a spot (between 1 and 9) #{player.name}: "
    player.position_choice
  end

  def display_invalid_position_notification
    puts "Position is not between 1 - 9 or it has already been taken, please choose again"
  end

  def get_players_choice(player)
    print "Do you want to play again? (y/n)"
    player.play_again_choice
  end

  def invalid_choice_notification
    clear_screen
    puts "Invalid choice, Please enter either 'y' or 'n'"
  end

end
