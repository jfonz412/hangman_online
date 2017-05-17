class Player
  attr_reader :chosen_letter

  def initialize
  	@already_picked_letters = []
  end

  public
  def pick_a_letter(letter)
    return false if validate(letter) == false
    @chosen_letter = letter
    @already_picked_letters << @chosen_letter
  end

  private
  def validate(letter)
  	letter.scan(/\d/) do 
  	  return false
  	end
    if letter == "save" #returns true so that this can be passed to game_saver
      true
    elsif letter.length != 1
      false
    elsif @already_picked_letters.include? letter
      false
    else
      true
    end
  end
end