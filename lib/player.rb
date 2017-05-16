class Player
  attr_reader :chosen_letter

  def initialize
  	@already_picked_letters = []
  end

  public
  def pick_a_letter
  	puts "Guess a letter"
    puts "(Enter \"save\" to save and quit)"
  	loop do
      @chosen_letter = gets.chomp.downcase
      break if validate(@chosen_letter) == true
    end
    @already_picked_letters << @chosen_letter
  end

  private
  def validate(chosen_letter)

  	chosen_letter.scan(/\d/) do 
  	  puts "No numbers please" 
  	  return false
  	end
    if chosen_letter == "save" #returns true so that this can be passed to game_saver
      true
    elsif chosen_letter.length != 1
      puts "Please choose a SINGLE letter"
      false
    elsif @already_picked_letters.include? chosen_letter
      puts "You already played that letter"
      false
    else
      true
    end

  end
end