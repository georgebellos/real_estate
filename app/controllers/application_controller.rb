class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user?(user)
    user == current_user
  end

  helper_method :current_user?
end
