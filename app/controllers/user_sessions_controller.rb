class UserSessionsController < ApplicationController

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
end
