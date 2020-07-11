# Will receive a jsonb with the state of a game, and build a boardState from that.
# This way by denormalizing the db we only access the db once per play

class Minesweeper::BoardState 
  def initialize(game_state)
    # boad = Board.new(game_state)
  end

  def discover_cell(x_coordinate, y_coordinate)
    # return if invalid cell
    # return if already discovered cell
    # return if cell contains bomb
    # uncover cell until no blanks left
  end

  def serialize
    {}
  end

  protected

  def

  end
end
