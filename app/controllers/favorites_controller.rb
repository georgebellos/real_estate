class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @property = Property.find(params[:id])
    if @property.favoritable_by?(current_user)
      current_user.favorites << @property
      redirect_to favorites_properties_path,
        notice: "You favorited #{ @property.category } at #{ @property.street }"
    else
      redirect_to :back, notice: "You can't favorite this property"
    end
  end

  def index
    @properties = current_user.favorites
  end

  def update
    @property = Property.find(params[:id])
    current_user.favorites.delete(@property)
    redirect_to :back,
      notice: "You unfavorited #{ @property.category } at #{ @property.street }"
  end

  def destroy
   current_user.favorites = []
   redirect_to :back
  end
end
