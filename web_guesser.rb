require 'sinatra'
require 'sinatra/reloader'

set :secret_number, rand(101)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess) 
  erb :index, :locals => {:secret_number => settings.secret_number, :message => message}
end

def check_guess(guess)
  message = "Too high!" if guess > settings.secret_number
  message = "Too low!" if guess < settings.secret_number
  message.insert(0, "Way ") if (settings.secret_number - guess).abs > 5
  message = "You got it right!" if guess == settings.secret_number
  message.capitalize
end

