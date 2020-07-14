class GamesController < ApplicationController
  def create
    new_game = Game.new(create_params)
    new_board_state = Minesweeper::Builder.new(create_params[:cols].to_i,
                                         create_params[:rows].to_i,
                                         create_params[:mines].to_i).build
    new_game.board = new_board_state.board
    if new_game.save
      render json: { game_id: new_game.id, board: new_game.board }
    else
      head :internal_server_error
    end
  end

  def create_params
    params.require(:game).permit(:mines, :cols, :rows)
  end
end
