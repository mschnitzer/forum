class BoardThreadPostsController < ApplicationController
  before_action :validate_thread

  def new; end

  def create
    @post = @thread.posts.new(
      user:           User.current.logged_in? ? User.current : nil,
      username:       User.current.guest? ? params[:username] : nil,
      title:          params[:title],
      message:        params[:message],
      thread_starter: @thread.user == User.current
    )

    authorize @post

    if @post.save
      flash.now[:success] = I18n.t :flash_board_thread_post_create_success
      response_status = :ok
    else
      flash.now[:error] = I18n.t :flash_board_thread_post_create_error, error: @post.errors.full_messages.to_sentence
      response_status = :unprocessable_entity
    end

    render layout: false, status: response_status
  end

  private

  def validate_thread
    @thread = BoardThread.find_by(id: params[:thread].to_i)
    not_found unless @thread
  end
end
