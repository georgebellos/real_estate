class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path
      flash[:success] = 'You have signed up successfully'
    else
      render :new
    end
  end
end
