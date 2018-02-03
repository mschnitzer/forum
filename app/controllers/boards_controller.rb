class BoardsController < ApplicationController
  def index
    @categories = Board.categories.order(position: :asc)
  end

  def show
    @board = Board.find_by(id: params[:board].to_i)
    not_found unless @board

    authorize @board

    if @board.to_param != params[:board]
      redirect_to boards_show_path(@board)
      return
    end

    @threads = policy_scope(@board.threads)
    @threads_count = @threads.count
  end
end
