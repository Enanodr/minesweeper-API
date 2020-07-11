module Minesweeper
  class CellBuilder
    attr_reader :value, :state, :mines_near

    def initialize(value: :empty, state: :hidden, mines_near: 0)
      @value = value
      @state = state
      @mines_near = value == :empty ? mines_near : -1
    end

    def build
      Cell.new(value: @value, state: @state, mines_near: @mines_near)
    end

    def has_mine?
      @value == :mine
    end

    def increment_mines_count
      @mines_near += 1 unless has_mine?
    end
  end
end
