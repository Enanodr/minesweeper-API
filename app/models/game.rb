class Game < ApplicationRecord
  validates :board, :mines, :rows, :cols, presence: true
end
