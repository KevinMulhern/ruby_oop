class TicTacToe
  def initialize
    system 'clear'
    @player1 = Player.new
    @player2 = Player.new
    @board = [" "] * 9
    @current_player = @player1
  end
  
  def play
    loop do 
      puts "In the loop"
      create_Board
      move(@current_player)
      system 'clear'

      if win?(@current_player)
        puts "#{@current_player.name} has won!"
        create_Board
        play_again?
      elsif tie?
        create_Board
	play_again?
      end
      switch_players
    end
  end

  protected

  def create_Board
    puts "\n\n"
    puts "\t   #{@board[0]} |  #{@board[1]} |  #{@board[2]} "
    puts "\t ----|----|---- "
    puts "\t   #{@board[3]} |  #{@board[4]} |  #{@board[5]} "
    puts "\t ----|----|---- "
    puts "\t   #{@board[6]} |  #{@board[7]} |  #{@board[8]} "
    puts "\n\n "
  end

  def tie?
    if @board.include?(" ")
      return false
    else
      puts "Its a tie!"
      return true
    end
  end

  def get_position
    valid = true
    while valid == true do
      print "Choose a spot (between 1 and 9) #{@current_player.name}: "
      pos = gets.chomp.to_i - 1
		
      if !valid_position?(pos)
        puts "Position has already been taken please choose again"
	valid = true
      elsif !valid_length?(pos)
	puts "Number must be between 1 and 9, please choose again"
	valid = true
      else
	valid = false
      end
    end
    return pos
  end

  def move(player)
    pos = get_position

    @board.each_index do |i|
      if i = pos
      	@board[pos] = player.symbol
      end
    end
  end

  def valid_length?(pos)
    if pos >= 0 && pos <= 8
      return true
    end
  end

  def valid_position?(pos)
    @board[pos] == " "
  end

  def switch_players
    if @current_player == @player1
      @current_player = @player2
    elsif @current_player == @player2
      @current_player = @player1
    end
  end

  def play_again?
    valid = true
    while valid == true
      print "Do you want to play again? (y/n)"
      choice = gets.chomp.downcase

      if choice == "y"
      	@board = [" "]* 9
      	system 'clear'
      	play 
      	valid = false
      elsif choice == 'n'
        exit
        valid = false
      else
        system 'clear'
        puts "Invalid choice, Please enter either 'y' or 'n'"
        valid = true
      end
    end
  end

  def win?(player)
    win_move = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,6], [0,4,8], [2,4,6]]
    win_move.any? do |m|
      m.all? {|pos| @board[pos] == player.symbol}
    end
  end
  
  class Player
    attr_reader :name, :symbol
    @@count = 0
    
    def initialize
      @@count += 1
      print "Please enter your name Player #{@@count}: "
      @name = gets.chomp
      @symbol = get_symbol
      puts "Hi #{@name} you will be #{@symbol}"
   end
   
   protected
   
   def get_symbol
     if @@count == 1
       symbol = "X"
     else
       symbol = "O"
     end
     return symbol
    end
  end
end

tictactoe = TicTacToe.new
tictactoe.play 
