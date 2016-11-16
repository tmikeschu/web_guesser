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
  unless settings.started? 
    settings.started = true
    return "Let's play!"
  end 
  message = "Too high!" if guess > settings.secret_number
  message = "Too low!" if guess < settings.secret_number
  message.insert(0, "Way ") if (settings.secret_number - guess).abs > 5
  message = "You got it right!" if guess == settings.secret_number
  @@guesses -= 1
  message.capitalize
end

