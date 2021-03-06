require 'sinatra'
require 'sinatra/reloader'

require './lib/word_picker.rb'
require './lib/word_space.rb'
require './lib/gallows.rb'
require './lib/dump.rb'
require './lib/board.rb'
require './lib/gamemaster.rb'
require './lib/player.rb'
require './lib/game_saver.rb'
require './lib/game_loader.rb'
require 'yaml'

# enable session features
configure do
  enable :sessions 
end

def new_word
  randomized_word = WordPicker.new
  secret_word = randomized_word.word.downcase
end

def new_objects(secret_word)
  game_objects = {
    game_master: game_master = GameMaster.new(secret_word),
    player: player = Player.new,
    hanging_man: hanging_man = Gallows.new,
    secret_word_space: secret_word_space = WordSpace.new(secret_word),
    letter_dump: letter_dump = Dump.new,
  }
end

secret_word = new_word
game_objects = new_objects(secret_word)

game_board = Board.new(game_objects)
#game_saver = GameSaver.new(game_objects)


get '/' do
	erb :index, 
	:locals => { 
              :image => game_objects[:hanging_man].image,     
		          :wrong_letters => game_objects[:letter_dump].wrong_letters.join(','),
		          :hidden_word => game_objects[:secret_word_space].hidden_word.join(' ') 
		          }
end

post '/' do
  letter = params['letter']
  
  unless game_objects[:player].pick_a_letter(letter) == false
	game_objects[:game_master].check_player_letter(game_objects[:player].chosen_letter)
    game_board.draw_board_objects(game_objects[:game_master].results)
  end
  
  # Check game for win/loss
  if game_objects[:secret_word_space].check_for_win == true
	  redirect to '/win'
	elsif game_objects[:hanging_man].turns == 6
	  redirect to '/lose'
	else
	  redirect to '/'
  end
end

get '/lose' do
	erb :lose, :locals => { :secret_word => secret_word }
end

get '/win' do
	erb :win, :locals => { :secret_word => secret_word }
end

get '/newgame' do
  secret_word = new_word
  game_objects = new_objects(secret_word)
  game_board = Board.new(game_objects)

  redirect to '/'
end