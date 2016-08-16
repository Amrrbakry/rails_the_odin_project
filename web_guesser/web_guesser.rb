require 'sinatra'
require 'sinatra/reloader'

secret_num = rand(100)

get '/' do
	"the SECRET NUMBER is #{secret_num}	"
end