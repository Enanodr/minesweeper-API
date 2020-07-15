RSpec.shared_context 'game created', shared_context: :metadata do
  let(:game) do
    board = Minesweeper::Builder.new(3,3,3).build.board
    Game.create({ cols: 3, rows: 3, mines: 3, board: board })
  end
end
