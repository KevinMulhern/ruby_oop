class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end

  def take_turn(player)
    puts "Please enter a position between 1 and 9 #{player.name}:"
    gets.chomp.to_i - 1
  end
end