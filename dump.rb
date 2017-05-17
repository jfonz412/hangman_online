class Dump
  attr_reader :wrong_letters
  def initialize
  	@wrong_letters = []
  end
  
  public
  def draw_self(results)
  	if results[:is_correct] == false && results[:letter] != nil
      @wrong_letters << results[:letter]
    end 
  end
end
