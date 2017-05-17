class Board
  def initialize(game_objects)
    @board_objects = game_objects.clone
  	# Board does not need these two objects
  	@board_objects.delete(:player)
  	@board_objects.delete(:game_master)
  end

  def draw_board_objects(results)
  	@board_objects.each do |key,object|
  	  object.draw_self(results)
  	end
  end
end