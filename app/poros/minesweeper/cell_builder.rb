module Minesweeper
  class CellBuilder
    attr_reader :value, :state, :mines_near

    def initialize(order_number:, value: :empty, state: :hidden, mines_near: 0)
      @order_number = order_number
      @value = value
      @state = state
      @mines_near = value == :empty ? mines_near : -1
    end

    def build
      Cell.new(order_number: @order_number, value: @value,
               state: @state, mines_near: @mines_near)
    end

    def mine?
      @value == :mine
    end

    def increment_mines_count
      @mines_near += 1 unless mine?
    end
  end
end
