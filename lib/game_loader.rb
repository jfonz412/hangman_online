class GameLoader
  attr_reader :loaded_game

  def initialize
  	check_for_file
  end
  
  private
  def check_for_file
    if File.exist? './save_game.yaml'
      puts "\nPrevious save found"
      puts "Do you want to load your last save?"
      puts "(Y/N)?"
      answer = gets.chomp.downcase
      load_file(answer)
    else
      puts "Starting a new game..."
    end
  end

  def load_file(answer)
    if answer == 'y' || answer == 'yes'
      serialized_game = File.read('./save_game1.yaml')
      @loaded_game = YAML.load(serialized_game)
      tweak_loaded_game
    else
      puts "Starting a new game..."
      puts "You can still quit and reload you previous game at this time."
    end
  end

  #ask game_master to tweak it's results hash (see gamemaster.rb for full explanation)
  def tweak_loaded_game
    @loaded_game[:game_master].tweak_results 
  end

end