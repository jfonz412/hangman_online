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

randomized_word = WordPicker.new
the_secret_word = randomized_word.word.downcase

game_objects = {
  game_master: game_master = GameMaster.new(the_secret_word),
  player: player = Player.new,
  hanging_man: hanging_man = Gallows.new,
  secret_word_space: secret_word_space = WordSpace.new(the_secret_word),
  letter_dump: letter_dump = Dump.new,
}

game_board = Board.new(game_objects)
game_saver = GameSaver.new(game_objects)


get '/' do
	erb :index, :locals => {:s_w => the_secret_word, :wrong_letters => game_objects[:letter_dump].wrong_letters }
end

post '/' do
	letter = params['letter']
  
	unless game_objects[:player].pick_a_letter(letter) == false
	  game_objects[:game_master].check_player_letter(game_objects[:player].chosen_letter)
    game_board.draw_board_objects(game_objects[:game_master].results)
  end

	redirect to '/'
end