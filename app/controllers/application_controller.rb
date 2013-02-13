class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in?
    return true if current_user
  end

  helper_method :current_user, :signed_in?, :current_user?
end
