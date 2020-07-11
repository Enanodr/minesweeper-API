class Minesweeper::Builder
  attr_reader :board
  def initialize(x, y, amount_of_mines)
    @x = x
    @y = y
    @amount_of_mines = amount_of_mines



  end

  def build
    initialize_board
    # 0 1 2
    # 3 4 5
    # 6 7 8

    total_cells = (@x * @y)

    total_cells.times do |i|
      has_mine = mine_locations.include? i

      @board[order_number_to_y(i)] << {
        x: order_number_to_x(i),
        y: order_number_to_y(i),
        has_mine: has_mine,
        mines_near: 0
      }
    end

    @board.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        if cell[:has_mine]
          cell[:mines_near] = -1
          update_adjacent_cell_mines_count(row_index + 1, col_index)
          update_adjacent_cell_mines_count(row_index - 1, col_index)
          update_adjacent_cell_mines_count(row_index, col_index + 1)
          update_adjacent_cell_mines_count(row_index, col_index - 1)
          update_adjacent_cell_mines_count(row_index + 1, col_index + 1)
          update_adjacent_cell_mines_count(row_index + 1, col_index - 1)
          update_adjacent_cell_mines_count(row_index - 1, col_index + 1)
          update_adjacent_cell_mines_count(row_index - 1, col_index - 1)
        end
      end
    end
  end

  protected

  def update_adjacent_cell_mines_count(row_index, col_index)
    return if row_index >= @y || row_index < 0 || col_index >= @x || col_index < 0

    cell_to_update = @board[row_index][col_index]
    cell_to_update[:mines_near] += 1 unless cell_to_update[:has_mine]
  end

  def mine_locations
    @mine_locations ||= (0..(@x * @y) - 1 ).to_a.sample(@amount_of_mines)
  end

  def order_number_to_x(n)
    n % @y
  end

  def order_number_to_y(n)
    n / @x
  end

  def initialize_board
    @board = []
    @y.times { @board << [] }
  end
end
