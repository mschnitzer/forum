class BoardThreadsController < ApplicationController
  before_action :check_board, only: %i[new create]

  def new
    if @board.to_param != params[:board]
      redirect_to board_threads_new_path(@board)
      return
    end

    authorize @board.threads.new

    @page_title = I18n.t :title_board_thread_new, board: @board
    @breadcrumbs.push([I18n.t(:breadcrumb_board_threads_new), board_threads_new_path(@board)])
  end

  def create
    thread = @board.threads.new(
      title: params[:title],
      user: User.current.logged_in? ? User.current : nil,
      username: User.current.guest? ? params[:username] : nil
    )

    authorize thread

    if thread.valid?
      post = prepare_thread_starter_post(thread)

      if post.valid?
        thread.save!

        post.thread = thread
        post.save!

        flash.now[:success] = 'The thread has been created successfully.'

        redirect_to board_threads_show_path(@board, thread)
        return
      else
        flash.now[:error] = I18n.t :flash_board_thread_create_error, error: post.errors.full_messages.to_sentence
      end
    else
      flash.now[:error] = I18n.t :flash_board_thread_create_error, error: thread.errors.full_messages.to_sentence
    end

    @breadcrumbs.push([I18n.t(:breadcrumb_board_threads_new), board_threads_new_path(@board)])
    render :new
  end

  def show
    @thread = BoardThread.find_by(id: params[:thread].to_i)
    not_found unless @thread

    authorize @thread

    @board = @thread.board

    if params[:board] != @board.to_param || params[:thread] != @thread.to_param
      redirect_to board_threads_show_path(@board, @thread)
      return
    end

    @page_title = @thread.title
    @posts = policy_scope(@thread.posts)

    @breadcrumbs.push([I18n.t(:breadcrumb_boards_show, board_name: @board.name), boards_show_path(@board)])
    @breadcrumbs.push([I18n.t(:breadcrumb_board_threads_show, thread_title: @thread.title), board_threads_show_path(@board, @thread)])
  end

  private

  def check_board
    @board = Board.find_by(id: params[:board].to_i)
    not_found unless @board

    @breadcrumbs.push([I18n.t(:breadcrumb_boards_show, board_name: @board.name), boards_show_path(@board)])
  end

  def prepare_thread_starter_post(thread)
    thread.posts.new(
      user: User.current.logged_in? ? User.current : nil,
      username: User.current.guest? ? params[:username] : nil,
      title: params[:title],
      message: params[:message],
      thread_starter: true
    )
  end
end
