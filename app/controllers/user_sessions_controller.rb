class UserSessionsController < ApplicationController
  before_filter :signed_in, only: [:new , :create]

  def new
  end

  def create
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => 'You are now signed in'
    else
      flash.now[:error] = 'Wrong email or password'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => 'You are now signed out'
  end

  private
  def signed_in
    redirect_to root_url if signed_in?
  end
end
