class Player
  @@player_number = 0

  attr_reader :name, :symbol
  def initialize
    @@player_number +=1
    @name = get_name
    @symbol = set_symbol
    show_symbol
  end

  def position_choice
    gets.chomp.to_i - 1
  end

  def play_again_choice
    gets.chomp.downcase
  end

  private

  def show_symbol
    puts "Hi #{name} you are #{symbol}"
  end

  def set_symbol
    player_number == 1 ? "X" : "O"
  end

  def player_number
    @@player_number
  end

  def get_name
    print "Please enter your name Player #{player_number}: "
    gets.chomp
  end
end
