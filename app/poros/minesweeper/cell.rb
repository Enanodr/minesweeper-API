module Minesweeper
  class Cell
    attr_accessor :value, :state, :mines_near
    def initialize(value:, state:, mines_near:)
      @value = value
      @state = state
      @mines_near = mines_near
    end

    def has_mine?
      value == :mine
    end
  end
end
