class UsersController < ApplicationController
  before_filter :correct_user, only: [:show]

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

  def show
    @user = User.find(params[:id])
  end

  private

  def correct_user
    user = User.find_by_id(params[:id])
    redirect_to root_path unless user && current_user == user
  end
end
