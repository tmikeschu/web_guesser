require 'sinatra'
require 'sinatra/reloader'

secret_number = rand(101)

get '/' do
  message = message_maker(params["guess"].to_i) 
  erb :index, :locals => {:secret_number => secret_number, :message => message}
end

def message_maker(guess)
  message = "Too high!" if guess > secret_number
  message = "Too low!" if guess < secret_number
  message.insert(0, "Way ")
  message = "You got it right!" if guess == secret_number
  message
end

get '/?' do
  # "Too low!" if params["guess"].to_i > secret_number
end
