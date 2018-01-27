class ApplicationController < ActionController::Base
  include ApplicationHelper
  include Pundit

  protect_from_forgery with: :exception
  around_action :catch_halt
  before_action :set_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    User.current
  end

  private

  def user_not_authorized
    catch :halt do
      permission_denied
    end
  end

  def set_user
    User.current = User.find_by(id: session[:user_id])
    reset_session if session[:user_id] && !User.current
  end

  def catch_halt
    catch :halt do
      yield
    end
  end
end
