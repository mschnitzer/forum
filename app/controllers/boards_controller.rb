class BoardsController < ApplicationController
  def index
    @categories = Board.categories.order(position: :asc)
  end

  def show
    @board = Board.find_by(id: params[:id])
    not_found unless @board

    @threads = @board.threads
  end
end
