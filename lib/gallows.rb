class Gallows
  attr_reader :turns

  def initialize
  	@turns = 0
    @man =  [
	    %q{
	       _____
	       |    | 
	            |
	            |
	            |
	            |
	      ========  
	    },

	    %q{
	       _____
	       |    | 
	       0    |
	            |
	            |
	            |
	      ========  
	    },

	    %q{
	       _____
	       |    | 
	       0    |
	       |    |
	            |
	            |
	      ========  
	    },

	    %q{
	       _____
	       |    | 
	      \0    |
	       |    |
	            |
	            |
	      ========  
	    },

	    %q{
	       _____
	       |    | 
	      \0/   |
	       |    |
	            |
	            |
	      ========  
	    },

	    %q{
	       _____
	       |    | 
	      \0/   |
	       |    |
	      /     |
	            |
	      ========  
	    },

	    %q{
	       _____
	       |    | 
	      \0/   |
	       |    |
	      / \   |
	            |
	      ========  
	    }
    ]
  end

  public
  def draw_self(results)
  	if results[:is_correct] == false && results[:letter] != nil
  	  @turns += 1
  	end
  	print @man[@turns]
  end
end