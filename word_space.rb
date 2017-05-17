class WordSpace
  attr_reader :hidden_word

  def initialize(word)
  	@hidden_word = hide_word(word)
  end

  public
  def draw_self(results)
  	if results[:is_correct] == true
      results[:indexes].each do |index|
        @hidden_word[index] = results[:letter] 
      end
    end
    print @hidden_word.join(' ')
    print "\n"
    print "\n"
  end

  def check_for_win
    if @hidden_word.include? "_"
      false
    else
      true
    end
  end

  private
  def hide_word(word)
    hidden_word = []
    word.length.times do
      hidden_word << "_"
    end
    hidden_word
  end
end