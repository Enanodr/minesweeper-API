module Minesweeper
  class Builder
    attr_reader :board
    def initialize(cols, rows, amount_of_mines)
      @cols = cols
      @rows = rows
      @amount_of_mines = amount_of_mines
    end

    def build
      initialize_board
      set_cell_numbers
      build_definitive_cells
      BoardState.new(@board)
    end

    private

    def set_cell_numbers
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          update_adjacent_cells(row_index, col_index) if cell.mine?
        end
      end
    end

    def build_definitive_cells
      @board.each { |row| row.map(&:build) }
    end

    def update_adjacent_cells(row, col)
      update_adjacent_cell_mines_count(row + 1, col)
      update_adjacent_cell_mines_count(row - 1, col)
      update_adjacent_cell_mines_count(row, col + 1)
      update_adjacent_cell_mines_count(row, col - 1)
      update_adjacent_cell_mines_count(row + 1, col + 1)
      update_adjacent_cell_mines_count(row + 1, col - 1)
      update_adjacent_cell_mines_count(row - 1, col + 1)
      update_adjacent_cell_mines_count(row - 1, col - 1)
    end

    def update_adjacent_cell_mines_count(row_index, col_index)
      return if row_index >= @rows || row_index.negative? ||
                col_index >= @cols || col_index.negative?

      cell_to_update = @board[row_index][col_index]
      cell_to_update.increment_mines_count unless cell_to_update.mine?
    end

    # TODO: move to a matrix class
    def order_number_to_x(number)
      number % @rows
    end

    # TODO: move to a matrix class
    def order_number_to_y(number)
      number / @cols
    end

    def initialize_board
      # Set the empty rows
      @board = []
      @rows.times { @board << [] }

      # Fill with empty cell_builders and the mines
      total_cells = (@cols * @rows)
      total_cells.times do |i|
        value = mine_locations.include?(i) ? :mine : :empty
        @board[order_number_to_y(i)] << CellBuilder.new(value: value, order_number: i)
      end
    end

    # Random location for the mines
    def mine_locations
      @mine_locations ||= (0..(@cols * @rows) - 1).to_a.sample(@amount_of_mines)
    end
  end
end
