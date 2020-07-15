# frozen_string_literal: true
require 'rails_helper'

describe GamesController, type: :controller do
  describe 'POST #create' do
    context 'when all params are correct' do
      before { post :create, params: { game: { rows: 4, cols:4 , mines: 3 } } }
      let(:game) { Game.last }
      include_examples 'renders the game correctly'

      it 'creates a game with the given params' do
        expect(game.rows).to eq(4)
      end

      it 'creates a game with the given params' do
        expect(game.cols).to eq(4)
      end

      it 'creates a game with the given params' do
        expect(game.mines).to eq(3)
      end

      it 'creates a board with correct amount of mines' do
        mines_count = game.board.flatten.count { |cell| cell['value'] == 'mine' }
        expect(mines_count).to eq(3)
      end

      it 'creates a board with correct dimentions' do
        expect(game.board.count).to eq(4)
        expect(game.board.first.count).to eq(4)
      end
    end

    context 'when rows param is missing' do
      before { post :create, params: { game: { cols:4 , mines: 3 } } }

      it 'responds with bad_request status code (400)' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when cols param is missing' do
      before { post :create, params: { game: { rows:4 , mines: 3 } } }

      it 'responds with bad_request status code (400)' do
        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when mines param is missing' do
      before { post :create, params: { game: { cols:4 , rows: 3 } } }

      it 'responds with bad_request status code (400)' do
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET #show' do
    context 'when game exists' do
      include_context 'game created'
      before { get :show, params: { id: game.id } }

      include_examples 'renders the game correctly'
    end
  end
end
