class GamesController < ApplicationController
  def create
    new_game = Game.new(create_params)
    new_board_state = Minesweeper::Builder.new(create_params[:cols].to_i,
                                         create_params[:rows].to_i,
                                         create_params[:mines].to_i).build
    new_game.board = new_board_state.board
    internal_server_error unless new_game.save
    render_game(new_game)
  end

  def show
    saved_game = Game.find(show_params[:id])
    render_game(saved_game)
  end

  private

  def render_game(game)
    render json: { game_id: game.id, board: game.board }
  end

  def show_params
    params.permit(:id)
  end

  def create_params
    [:mines, :cols, :rows].each { |param| params.require(:game).require(param) }
    params.require(:game).permit(:mines, :cols, :rows)
  end
end
