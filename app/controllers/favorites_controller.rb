class FavoritesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @property = Property.find(params[:id])
    if current_user.properties.include?(@property)
      redirect_to property_path(@property),
        alert: 'You can not favorite a listing you have created'
    else
      make_favorite(@property)
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

  private

  def make_favorite(property)
    if current_user.favorites.include?(@property)
      redirect_to :back,
        alert: 'You have already favorited this property'
    else
      current_user.favorites << @property
      redirect_to favorites_properties_path,
        notice: "You favorited #{ @property.category } at #{ @property.street }"
    end
  end
end
