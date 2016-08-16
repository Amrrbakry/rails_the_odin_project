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
		message = "Correct guess!!\n The secret number is #{SECRET_NUM}."
	else
		message = "Not valid guess"
	end
end


get '/' do

	guess = params['guess'].to_i
	message = check_guess(guess)
	erb :index, :locals => { :secret_num => SECRET_NUM, :message => message }

end