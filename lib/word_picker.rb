class WordPicker
  attr_reader :word

  def initialize
  	@word = randomize_word
  end

  private
  def randomize_word
  	full_dictionary = load_dictionary
  	filtered_dictionary = filter_dictionary(full_dictionary)
  	
  	index_value = 1 + rand(filtered_dictionary.length)
  	filtered_dictionary[index_value]
  end

  def load_dictionary
  	File.read('./lib/dictionary.txt').split
  end

  def filter_dictionary(full_dictionary)
    full_dictionary.each_with_index do |word,index|
      if word.length > 12 || word.length < 5
      	full_dictionary.delete_at(index)
      end
  end
  full_dictionary
  end

end