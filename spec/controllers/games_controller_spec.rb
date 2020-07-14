# frozen_string_literal: true
require 'rails_helper'

describe GamesController, type: :controller do
  describe 'POST #create' do
    before { post :create, params: { game: {rows: 4, cols:4 , mines: 3 }}}

    it 'creates a game with the given params' do
      expect(Game.last.rows).to eq(4)
    end

    it 'creates a game with the given params' do
      expect(Game.last.cols).to eq(4)
    end

    it 'creates a game with the given params' do
      expect(Game.last.mines).to eq(3)
    end

    it 'creates a board with correct amount of mines' do
      mines_count = Game.last.board.flatten.count { |cell| cell['value'] == 'mine' }
      expect(mines_count).to eq(3)
    end

    it 'creates a board with correct dimentions' do
      expect(Game.last.board.count).to eq(4)
      expect(Game.last.board.first.count).to eq(4)
    end
  end
end
