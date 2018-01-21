class BoardsController < ApplicationController
  def index
    @boards = Board.order(position: :asc)
  end
end
