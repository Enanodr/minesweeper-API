RSpec.shared_context '4 x 4 Board with one mine in the corner',
                     shared_context: :metadata do
  let(:board) do
    [
      [
        Minesweeper::Cell.new(order_number: 0, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 1, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 2, value: :empty, state: :hidden, mines_near: 1),
        Minesweeper::Cell.new(order_number: 3, value: :mine, state: :hidden, mines_near: -1)
      ],
      [
        Minesweeper::Cell.new(order_number: 4, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 5, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 6, value: :empty, state: :hidden, mines_near: 1),
        Minesweeper::Cell.new(order_number: 7, value: :empty, state: :hidden, mines_near: 1)
      ],
      [
        Minesweeper::Cell.new(order_number: 8, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 9, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 10, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 11, value: :empty, state: :hidden, mines_near: 0)
      ],
      [
        Minesweeper::Cell.new(order_number: 12, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 13, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 14, value: :empty, state: :hidden, mines_near: 0),
        Minesweeper::Cell.new(order_number: 15, value: :empty, state: :hidden, mines_near: 0)
      ]
    ]
  end
end
