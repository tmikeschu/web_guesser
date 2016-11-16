require 'sinatra'
require 'sinatra/reloader'

@@guesses = 5
@@message = ""

set :secret_number, rand(101)
disable :started
  
get '/' do
  check_status
  @@guess = params["guess"].to_i
  @@message = check_guess(@@guess) 
  erb :index, :locals => {:secret_number => settings.secret_number, :message => @@message, :guesses => @@guesses}
end

def check_status
  if @@guesses == 0 || @@message.include?("right")
    settings.secret_number = rand(101)
    @@guesses = 5
    @@guess = 0
  end
end

def check_guess(guess)
  return new_game unless settings.started? 
  @@guesses -= 1
  high_low_right(guess)
end

def new_game
  settings.started = true
  "Let's play!"
end

def high_low_right(guess)
  message = if guess > settings.secret_number
    "Too high!" 
  elsif guess < settings.secret_number
    "Too low!" 
  else 
    "You got it right!"
  end
  message.insert(0, "Way ") if (settings.secret_number - guess).abs > 5
  message.capitalize
end

