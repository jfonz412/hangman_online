class Gallows
  attr_reader :turns, :image

  def initialize
  	@turns = 0
    @man =  [ 
    	      "public/images/hangman.jpg",
    	      "/images/hangman_1.jpg",
    	      "/images/hangman_2.jpg",
    	      "images/hangman_3.jpg",
    	      "images/hangman_4.jpg",
    	      "images/hangman_5.jpg",
    	      "images/hangman_6.jpg"
    	    ]  
    @image = @man[@turns]          
  end

  public
  def draw_self(results)
  	if results[:is_correct] == false && results[:letter] != nil
  	  @turns += 1
  	end
  	@image = @man[@turns]
  end
end