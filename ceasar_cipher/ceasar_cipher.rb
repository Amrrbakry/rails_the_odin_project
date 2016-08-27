require 'sinatra'
require 'sinatra/reloader' if development?

get "/" do
	erb :index
end

post "/" do
	@cipher = ceasar_cipher(params[:text], params[:shift_factor].to_i)
	erb :index
end

get "/decipher" do 
	erb :decipher
end

post "/decipher" do
	@text = decipher(params[:cipher], params[:shift_factor].to_i)
	erb :decipher
end

def ceasar_cipher(text, shift_factor)
	lower_case_letters = ('a'..'z').to_a
	upper_case_letters = ('A'..'Z').to_a
	ciphered_text = ""

	text.each_char do |letter| 
		if lower_case_letters.include? letter
			letter_index = lower_case_letters.index letter
			letter = lower_case_letters[(letter_index + shift_factor) % 26]
		elsif upper_case_letters.include? letter
			letter_index = upper_case_letters.index letter
			letter = upper_case_letters[(letter_index + shift_factor) % 26]
		end
		ciphered_text << letter
	end
	ciphered_text
end

ceasar_cipher("What a string!", 5) # => "Bmfy f xywnsl!"

# this method can be used to decipher the code orignally ciphered by the previous method

def decipher(text, shift_factor)
	lower_case_letters = ("a".."z").to_a
	upper_case_letters = ("A".."Z").to_a
	deciphered_text = ""

	text.each_char do |letter|
		if lower_case_letters.include? letter
			letter_index = lower_case_letters.index letter
			letter = lower_case_letters[(letter_index + (26 - shift_factor)) % 26]
		elsif upper_case_letters.include? letter
			letter_index = upper_case_letters.index letter
			letter = upper_case_letters[(letter_index + (26 - shift_factor)) % 26]
		end
		deciphered_text << letter

	end

	deciphered_text 

end

decipher("Bmfy f xywnsl!", 5) # => What a string!
			
