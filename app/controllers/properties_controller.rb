class PropertiesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def new
    @property = Property.new
    @property.images.build
  end

  def create
    @property = current_user.properties.build(params[:property])
    if @property.save
      redirect_to @property
      flash[:success] = 'You have created a new property'
    else
      render :new
    end
  end

  def show
    @property = Property.find(params[:id])
    @json = @property.to_gmaps4rails
    @favs_quicklist = current_user.favorites.includes(:images).limit(4) if current_user
    @compares_quicklist = Property.includes(:images).find(session[:compare_list] || [])
  end

  def index
    @favs_quicklist = current_user.favorites.includes(:images).limit(4) if current_user
    @compares_quicklist = Property.includes(:images).find(session[:compare_list] || [])

    @properties = if params[:search].present?
                    Property.search(params)
                  elsif params[:sort].present?
                    Property.order('price ' + sort_order).includes(:images).page(params[:page]).per(18)
                  else
                    Property.includes(:images).page(params[:page]).per(18)
                  end

    @partial = if ['list', 'grid'].include?(params[:view])
                   cookies[:view ] = params[:view]
                 else
                   cookies[:view] || 'grid'
                 end
  end

  def rent
    @properties = Property.rent.page(params[:page]).per(12)
    @favs_quicklist = current_user.favorites.includes(:images).limit(4) if current_user
    @compares_quicklist = Property.includes(:images).find(session[:compare_list] || [])
    render :index
  end

  def buy
    @properties = Property.buy.page(params[:page]).per(12)
    @favs_quicklist = current_user.favorites.includes(:images).limit(4) if current_user
    @compares_quicklist = Property.includes(:images).find(session[:compare_list] || [])
    render :index
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update_attributes(params[:property])
      redirect_to property_path
      flash[:success] = 'Property has been updated'
    else
      render :edit
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    flash[:success] = 'Property has been destroyed'
    redirect_to properties_path
  end

  private

  def correct_user
    redirect_to root_path if current_user.properties.find_by_id(params[:id]).nil?
  end

  def sort_order
    %w[asc desc].include?(params[:sort]) ? params[:sort] : "asc"
  end
end
