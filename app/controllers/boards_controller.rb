class BoardsController < ApplicationController
  def index
    @categories = Board.categories.order(position: :asc)
  end
end
