class Mastermind
	LETTERS = ["R", "B", "Y", "G", "O", "P"]
	attr_accessor :guess
	def initialize
		@mode = 0
		@guess = []
		@hint = []
		@code = []
		@human_player = HumanPlayer.new
		@computer_player = ComputerPlayer.new
	end

# This method allows the user to choose the mode they want to play
# they can either be the code breaker or code maker
	def set_up_game
		system 'clear'
		@human_player.get_name
		choose_mode
		if @mode == 1
			play_as_codebreaker
		elsif @mode == 2
			play_as_codemaker
		end
	end



# This method makes shows the mode options and makes sure that the mode that the user
# chooses is valid.
	def choose_mode
		valid = false
		while valid == false
			puts "Hi #{@human_player.name} do you want to be the code maker or"
			puts "the code breaker?"
			puts "1. for code breaker"
			puts "2. for code maker"
			puts
			print "Please choose an option: "
			@mode = gets.chomp.to_i

			if @mode > 0 && @mode <= 2 
			valid = true
			else
				system 'clear'
				puts "Invalid selection, please choose either option 1 or 2."
			end
		end
	end

# This method will be run if the user chooses the code maker mode.
# it asks the user to enter a 4 letter code and makes sure it is valid
# the computer then makes a random intial guess from the letters array
# the results of this guess will be shown
# the computer then takes the hints into consideration for its next guess
# if the hints contain any exacts, the computer will keep these
# if the the hints contain any nears, they will keep them but put them in
# another random posistion.
# if they have any nopes they wont use them again
# this will repeat until the computer has guessed the code directly
# or if the iteration runs out.
	def play_as_codemaker
		system 'clear'
		puts "Letters to choose from: #{LETTERS.inspect}"
		print "Please enter your guess for the four letter code: \n"
		@code = @human_player.enter_code
		
		puts
		i = 1
		while i < 11
			if i == 1
				@guess = @computer_player.intial_guess
			else
				@guess = @computer_player.final_array
				@computer_player.temp = []
			end
			puts "Guess Number: #{i}"
			get_results


			puts "The computer player is making his guess #{i}: "
			3.times do
				print (".")
				sleep(1)
			end
			show_result
			@computer_player.logic(@hint, @guess)
			@computer_player.any_nil?
			@computer_player.final_array
			if win?
				puts "The computer has won!"
				play_again?
			end

			i += 1
		end
		puts "You have won!"
		play_again?




	end



# This method detemines the hints from the guess array and
# fills the hints array with the following:
# The hint will be exact if the guess is the same letter as the code and in the same position
# the hint will be near if the guess is just the same letter but not in the same position as the code
# the hint will be nope if the guess letter is not in the code
	def get_results
		i = 0
		while i < @guess.length
			if @guess[i] == @code[i]
				@hint[i] = "Exact" 
		elsif @code.include?(@guess[i])
				@hint[i] = "Near" 
		else
			@hint[i] = "Nope" 
		end
		i += 1
		end
		return @hint
	end


# This method outputs the results of the guess to the screen
# It shows the guess and the coresponding hints below it
	def show_result
			puts "\n"
			puts "\t   Choice 1 \t Choice 2\t Choice 3\t Choice 4"
			puts "-" * 70
			puts "Guess  |\t#{@guess[0]}\t    #{@guess[1]}\t\t    #{@guess[2]}\t\t    #{@guess[3]}"      
			puts "Result |\t#{@hint[0]} \t   #{@hint[1]} \t   #{@hint[2]} \t   #{@hint[3]}"
			puts "\n"
	end


# This method runs when the user chooses the code breaker mode
# It first gets the computer to generate a random code from the letters array
# it then starts a loop, each time it asks for the user to enter thier guess
# and it will output the results to the screen.
# it will stop when the user guesses the code correctly or when the iteration reaches 10
	def play_as_codebreaker
		system 'clear'
		i = 1
		@code = @computer_player.generate_code
		while i < 11
			puts "\n"
			puts "Letters to choose from: #{LETTERS}"
			puts "\n"
			print "Please enter your guess for the four letter code: \n"
			@guess = @human_player.enter_guess
			get_results
			puts "\n"
			puts "Guess Number: #{i}"
			show_result


			if win?
				puts "You have Won!"
				play_again?
			end

			i += 1
		end
		puts "You have lost!"
		play_again?
	end


# This method checks to see if all the elements in the hint array
# equal 'Exact' when they do, the method will return true
	def win?
		@hint.all? {|a| a == "Exact"}
	end

# This gives the user the option to play again by going by to
# the set up game method. It also checks to ensure the user has
# entered a valid option
	def play_again?
		again = false
		while again == false
			print "Do you want to play again? (y/n): "
			input = gets.chomp.downcase
			if input == "y"
				again = true
				load './mastermind.rb'
				system 'clear'
				set_up_game
			elsif input == "n"
				again = true
				exit
			else
				puts "Invalid input, Please enter either 'y' or 'n'."
			end
		end
	end








	class HumanPlayer
		attr_accessor :name
		def initialize
			@name = nil
		end

		def get_name
			print "What is your name: "
			@name = gets.chomp
		end

		def enter_guess
			guess = []
			i = 0
			while i < 4
				print "Letter #{i + 1}: "
				guess[i] = gets.chomp.upcase
				if LETTERS.include?(guess[i])
					i += 1
				else
					puts "Invalid letter please choose again"
				end
			end
			return guess
		end

		def enter_code
			code = []
			i = 0

			while i < 4
				print "Letter #{i + 1}: "
				code[i] = gets.chomp.upcase
				if LETTERS.include?(code[i])
					i += 1
				else
					puts "Invalid letter please choose again"
				end
			end
			return code
		end
	end


	class ComputerPlayer
			attr_accessor :final_array, :temp, :possible_letters
		def initialize
			@temp = Array.new(4)
			@intial_guess = []
			@free_indexes = []
			@final_array = []
			@possible_letters = LETTERS
		end


# This method generates a random code from the letters array
		def generate_code
			LETTERS.sample(4)
		end

# This method makes the computers intial guess, 4 random letters from the letters array
		def intial_guess
			while  @intial_guess.size < 4
				@intial_guess << LETTERS[rand(LETTERS.size)]
				@intial_guess.uniq!
			end
			return @intial_guess
		end


# This method contains the logic for the computers guesses
# It first checks if any of the hints returned are "Exact"
# if there any, it will add these to a temp array and then
# check for any hints that are equal to "near" if there are
# any it will keep them and put them in a different position
# in the temp array. It will then check if there are any 
# "nope" hints. If there are any it will delete them from the
# array of possible letters. The final array is then made from
# the temp array and is returned. This will be used as the 
# computers next guess
		def logic(hint, guess)
			i = 0
			while i < hint.size
				if hint[i] == "Exact"
					@temp[i] = guess[i]
					@possible_letters.delete(guess[i])
				elsif hint[i] == "Near"
					if @temp.count(guess[i]) > 1 || @final_array.count(guess[1]) > 1
						find_empty_indexes
						@temp[@new_index] = choose_random_letter(guess[i])
					else
						find_empty_indexes
						@temp[@new_index] = guess[i]
					end
				elsif hint[i] == "Nope"
					@possible_letters.delete(guess[i])
					@temp[i] = @possible_letters[rand(@possible_letters.size)]
				end
				i += 1
			end
			@final_array = @temp
			return @final_array
		end


# This method checks to see if any elements in the temp array are equal to nil
# if they are, they will be assigned a new random letter.
		def any_nil?
			i = 0
			while i < 4
				if @temp[i] == nil
					@temp[i] = @possible_letters[rand(@possible_letters.length)]
				end
				i += 1
			end
			@final_array = @temp
			return @final_array
		end


# This method chooses a random letter from the possible_letters array
		def choose_random_letter(letter)
			new_letter = letter

			while new_letter == letter
				new_letter = @possible_letters[rand(@possible_letters.size)]
			end 
		return new_letter
	end


# This method finds any empty indexes in the temp array
	def find_empty_indexes
		i = 0
		@free_indexes.clear
		while i < 4
			if @temp[i] == nil
				@free_indexes << i
			end
				i += 1
			end
			@new_index = @free_indexes[rand(@free_indexes.size)]
			return @new_index
		end
	end
end



mastermind = Mastermind.new
mastermind.set_up_game