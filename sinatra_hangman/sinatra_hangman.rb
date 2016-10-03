require "sinatra"
require "sinatra/reloader" if development?

enable :sessions

get '/' do
	if session[:game_over] == true || session[:secret_word] == nil
		redirect to("/newgame")
	end
	variables
	check_game_status
	erb :index
end

get '/newgame' do
	session[:secret_word] = random_word
	session[:hidden_word] = hide_secret_word(session[:secret_word])
	session[:word_array] = word_to_array(session[:secret_word])
	session[:wrong_guesses] = []
	session[:tries] = 7
	session[:game_over] = false
	redirect to('/')
end

post '/' do
	check_guess(params["guess"])
	redirect to('/')
end

get '/win' do
	if session[:word_array].join != session[:hidden_word]
		redirect to('/lost')
	end
	variables
	session[:game_over] = true
	erb :win
end

get '/lose' do 
	variables
	session[:game_over] = true
	erb :lose
end

helpers do

	def variables 
		@secret_word = session[:secret_word]
		@hidden_word = session[:hidden_word]
		@word_array = session[:word_array]
		@wrong_guesses = session[:wrong_guesses]
		@tries = session[:tries]
	end

	# picks a random word(5 to 12 chars long) from the words.txt dictionary
	def random_word
		file = File.read("./public/words.txt")
		words = file.split
		valid_words = words.select { |word| word.length > 4 && word.length < 13 }
		valid_words.sample
	end

	# replaces word letters with underscores to hide them 
	def hide_secret_word(word)
		hidden_word = word.gsub(/./,"-")
	end

	def check_game_status
		if session[:word_array].join == session[:hidden_word]
			redirect to('/win')
		elsif session[:tries] == 0
			redirect to('/lose')	
		end
	end

	# returns each letter of the secret word in array => ["s", "e", "c", "r", "e", "t"]
	def word_to_array(word)
		new_word = word.scan(/./)
		new_word[0].downcase!
		new_word
	end	

	# replaces chars that has not been guessed correct with a dash "-" based on the position from char_positions
	def show_correct_guesses(positions)
		correct_guess = session[:secret_word]
		positions.each do |position|
			correct_guess = correct_guess.gsub(correct_guess[position], session[:hidden_word][position])
		end
		correct_guess
	end

	# returns an array of the positions that has not been guessed right
	def hidden_char_position(guess)
			positions = []
			session[:word_array].each_with_index do |char, index|
				if char != guess.downcase
					positions << index
				end
			end
			positions
	end

	# checks if the guessed letter is correct or not
	def check_guess(letter)
		correct_guess = false
		if session[:wrong_guesses].include?(letter)
			# letter already guessed
			return
		end
		session[:word_array].each_with_index do |l , i|
			if l == letter.downcase
				# correct guess
				positions = hidden_char_position(letter)
				session[:hidden_word] = show_correct_guesses(positions)
				correct_guess = true
			end
		end
		
		unless correct_guess
				session[:wrong_guesses] << letter.downcase
				session[:tries] -= 1
		end
	end

end