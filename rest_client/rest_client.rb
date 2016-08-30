require 'rest_client'

# a search query on google using RestClient to make HTTP get request

puts "Searching Google"
puts 
puts "What do you want to search for?"

q = gets.chomp
result = RestClient.get 'https://www.google.com?q=' + q
puts "The webpage will now be printed as a string"
puts result.to_s