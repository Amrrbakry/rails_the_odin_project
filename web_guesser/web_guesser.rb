require 'sinatra'
require 'sinatra/reloader'

SECRET_NUM = rand(100)

def check_guess(guess)
	if guess > SECRET_NUM + 5
		message = "Way Too High!"
	elsif guess < SECRET_NUM - 5
		message = "Way Too Low!"
	elsif guess > SECRET_NUM
		message = "Too High!"
	elsif guess < SECRET_NUM
		message = "Too Low!"
	elsif guess == SECRET_NUM
		message = "Correct guess!! The secret number is #{SECRET_NUM}."
	else
		message = "Not valid guess"
	end
end

def change_bg_color(message) 
	if message == "Way Too High!" || message == "Way Too Low!" 
		background_color = "#E52D2D"
	elsif message == "Too High!" || message == "Too Low!"
		background_color = "#EC6C6C"
	else
		background_color = "green"
	end	
end


get '/' do

	guess = params['guess'].to_i
	cheat_mode = params['cheat']
	if cheat_mode == 'true' 
		cheat = "The secret number is #{SECRET_NUM}"
	else 
		""
	end
	message = check_guess(guess)
	background_color = change_bg_color(message)	
	erb :index, :locals => { :secret_num => SECRET_NUM, :message => message, :background_color => background_color, :cheat => cheat }

end