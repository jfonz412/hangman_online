class GameMaster
  attr_reader :results, :secret_word

  def initialize(the_secret_word)
  	@secret_word = the_secret_word
    @results = {
  	  letter: nil,
  	  indexes: [],
  	  is_correct: false
  	}
  end

  public
  def check_player_letter(player_letter)
  	# Has to be reset everytime
    @results = {
  	  letter: player_letter,
  	  indexes: [],
  	  is_correct: false
  	}
    
    # IS PLAYER TRYING TO SAVE?

  	@secret_word.split('').each_with_index do |secret_letter,secret_index|
  	  if secret_letter == player_letter
        @results[:indexes] << secret_index
        @results[:is_correct] = true
  	  end
  	end
  end
  
=begin

  The following method is a result of some of my game objects being a little too dependent on
    game_master's results hash. It was fine before implementing save/load, but jumping
    back into the game-loop without issue proved difficult.

  :letter is set to '!' so it forced letter_dump to draw itself (it won't if letter is nil, which it
    seems to set itself to when the game loads, not entirely sure why...)

  :is_correct is set to true so that it doesn't trigger hanging_man to advance another turn, nor will 
    it add the '!' to the letter_dump

  :indexes is left empty, so (even though the :is_correct is true, secret_word_space will not have an
    index value to add it to the array)

  This could possibly be prevented/improved upon by playing around with the actual game-loop in game.rb,
    but the program is now fully functional and I am ready to move on

=end
  def tweak_results
    @results = {
      letter: '!',
      indexes: [],
      is_correct: true
    }
  end
end