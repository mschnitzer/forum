class UsersController < ApplicationController
  def new
    @breadcrumbs.push([I18n.t(:breadcrumb_users_new), users_new_path])
  end

  def register
    @breadcrumbs.push([I18n.t(:breadcrumb_users_new), users_new_path])
    user = User.new(
      username:              params[:username],
      email:                 params[:email],
      email_confirmation:    params[:email_confirmation],
      password:              params[:password],
      password_confirmation: params[:password_confirmation]
    )

    if user.save
      session[:user_id] = user.id

      flash[:success] = I18n.t :flash_account_registered_successfully
      redirect_to root_path
    else
      flash.now[:error] = I18n.t :flash_account_registration_error, error: user.errors.full_messages.to_sentence
      render :new
    end
  end

  def login
    permission_denied if User.current.logged_in?
    @breadcrumbs.push([I18n.t(:breadcrumb_users_login), users_login_path])
  end

  def login_perform
    permission_denied if User.current.logged_in?

    user = User.find_by(username: params[:username]).try(:authenticate, params[:password])
    @breadcrumbs.push([I18n.t(:breadcrumb_users_login), users_login_path])

    if user
      session[:user_id] = user.id

      flash[:success] = I18n.t :flash_login_successfully
      redirect_to root_path
    else
      flash[:error] = I18n.t :flash_login_failed
      render :login
    end
  end

  def logout
    permission_denied if User.current.guest?

    reset_session

    flash[:success] = I18n.t :flash_logout_successfully
    redirect_to root_path
  end
end
