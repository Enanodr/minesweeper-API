# Will receive a jsonb with the state of a game, and build a boardState from that.
# This way by denormalizing the db we only access the db once per play
class Minesweeper::BoardState
  attr_reader :board
  def initialize(board)
    @board = board
  end

  def discover_cell(x_coordinate, y_coordinate)
    return if coorinates_out_of_board_range?(x_coordinate, y_coordinate)
    @board[y_coordinate][x_coordinate].discover(self)
  end

  def serialize
    @board.map do |row|
      row.map { |cell| cell.serialize }
    end
  end

  def order_number_to_x(number)
    number % @board.count
  end

  # TODO: move to a matrix class
  def order_number_to_y(number)
    number / @board.first.count
  end

  # For debugging
  def pretty_print
    puts "======================"
    @board.each do |row|
      row_string = ""
      row.each { |cell| row_string << cell.to_status_sym }
      puts row_string
    end
    puts "======================"
  end

  protected

  def coorinates_out_of_board_range?(x_cord, y_cord)
    x_cord >= cols || x_cord.negative? || y_cord >= rows || y_cord.negative?
    # raise 'coords not in range' if coordinates_out_of_range
  end

  def rows
    @board.count
  end

  def cols
    @board.first.count
  end
end
