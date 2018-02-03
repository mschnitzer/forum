class UsersController < ApplicationController
  def new; end

  def register
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
end
