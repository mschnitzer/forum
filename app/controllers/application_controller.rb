class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception
  around_action :catch_halt

  private

  def catch_halt
    catch :halt do
      yield
    end
  end
end
