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

puts "\n"
puts "WELCOME TO HANGMAN!!!"


=begin
  if the user choses to load a game, it will fill game_objects with the previous game's data
  else it will create a brand new set of objects to fill 'game_objects' hash.
  the game objects hash is a convienent way to pass objects to game_board, with receives the 
  results of each of the player's guess and instructs the objects to draw themselves accordingly.

  The goal was for each object to take care of it's own business, and for each object to have
  just one responsibility. This helped isolate issues and bugs, and made most of the project
  a pleasure to code...until I got to the save/reload feature, where some of my design issues 
  (mainly with the game-loop itself) were exposed. 
=end


# ----------------CREATE/LOAD GAME OBJECTS-------------------
game_loader = GameLoader.new

if game_loader.loaded_game != nil
  game_objects = game_loader.loaded_game 
  the_secret_word = game_objects[:game_master].secret_word
else
  randomized_word = WordPicker.new
  the_secret_word = randomized_word.word.downcase

  game_objects = {
    game_master: game_master = GameMaster.new(the_secret_word),
    player: player = Player.new,
    hanging_man: hanging_man = Gallows.new,
    secret_word_space: secret_word_space = WordSpace.new(the_secret_word),
    letter_dump: letter_dump = Dump.new,
  }
end

game_board = Board.new(game_objects)
game_saver = GameSaver.new(game_objects)


# ---------------GAME STARTS HERE--------------------
# draw initial game board
game_board.draw_board_objects(game_objects[:game_master].results)

# game loop
loop do 
  game_objects[:player].pick_a_letter
  
  if game_objects[:player].chosen_letter == "save"
  	game_saver.save_game
  	break
  end

  game_objects[:game_master].check_player_letter(game_objects[:player].chosen_letter)
  game_board.draw_board_objects(game_objects[:game_master].results)

  if game_objects[:secret_word_space].check_for_win == true
  	puts "\nYou win!!!"
  	break
  end

  if game_objects[:hanging_man].turns == 6
    puts "Sorry, game over..."
    puts "The secret word was \"#{the_secret_word}\""
    break
  end

end


