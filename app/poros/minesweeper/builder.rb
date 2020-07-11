module Minesweeper
  class Builder
    attr_reader :board
    def initialize(x, y, amount_of_mines)
      @x = x
      @y = y
      @amount_of_mines = amount_of_mines
    end

    def build
      initialize_board
      set_cell_numbers
      build_definitive_cells
    end

    private

    def set_cell_numbers
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          update_adjacent_cells(row_index, col_index) if cell.has_mine?
        end
      end
    end

    def build_definitive_cells
      @board.each { |row| row.map { |cell| cell.build }}
    end

    def update_adjacent_cells(y, x)
      update_adjacent_cell_mines_count(y + 1, x)
      update_adjacent_cell_mines_count(y - 1, x)
      update_adjacent_cell_mines_count(y, x + 1)
      update_adjacent_cell_mines_count(y, x - 1)
      update_adjacent_cell_mines_count(y + 1, x + 1)
      update_adjacent_cell_mines_count(y + 1, x - 1)
      update_adjacent_cell_mines_count(y - 1, x + 1)
      update_adjacent_cell_mines_count(y - 1, x - 1)
    end

    def update_adjacent_cell_mines_count(row_index, col_index)
      return if row_index >= @y || row_index < 0 ||
        col_index >= @x || col_index < 0
      cell_to_update = @board[row_index][col_index]
      cell_to_update.increment_mines_count unless cell_to_update.has_mine?
    end

    # TODO: move to a matrix class
    def order_number_to_x(n)
      n % @y
    end

    # TODO: move to a matrix class
    def order_number_to_y(n)
      n / @x
    end

    def initialize_board
      # Set the empty rows
      @board = []
      @y.times { @board << [] }

      # Fill with empty cell_builders and the mines
      total_cells = (@x * @y)
      total_cells.times do |i|
        value = mine_locations.include?(i) ? :mine : :empty
        @board[order_number_to_y(i)] << CellBuilder.new(value: value)
      end
    end

    # Random location for the mines
    def mine_locations
      @mine_locations ||= (0..(@x * @y) - 1 ).to_a.sample(@amount_of_mines)
    end
  end
end
