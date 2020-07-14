module Minesweeper
  class Cell
    attr_reader :value, :state
    def initialize(value:, state:, mines_near:, order_number:)
      @value = value
      @state = state
      @mines_near = mines_near
      @order_number = order_number
    end

    def mines_near
      return -1 if mine?
      @mines_near
    end

    def mine?
      value == :mine
    end

    def hidden?
      @state == :hidden
    end

    def to_status_sym
      return '-' if hidden?
      mine? ? 'M' : mines_near.to_s
    end

    def mine?
      @value == :mine
    end

    def serialize
      {
        value: @value,
        state: @state,
        mines_near: mines_near
      }
    end

    def discover(board)
      return unless hidden?
      @state = :exposed
      return unless mines_near == 0
      current_row = board.order_number_to_y(@order_number)
      current_col = board.order_number_to_x(@order_number)
      board.discover_cell(current_col, current_row + 1)
      board.discover_cell(current_col, current_row - 1)
      board.discover_cell(current_col + 1, current_row)
      board.discover_cell(current_col - 1, current_row)
      board.discover_cell(current_col + 1, current_row + 1)
      board.discover_cell(current_col + 1, current_row - 1)
      board.discover_cell(current_col - 1, current_row + 1)
      board.discover_cell(current_col - 1, current_row - 1)
    end
  end
end
