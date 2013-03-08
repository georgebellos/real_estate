class PropertiesController < ApplicationController
  before_filter :signed_in, only: [:new, :create, :edit, :update, :destroy ]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def new
    @property = Property.new
    @property.images.build
  end

  def create
    @property = current_user.properties.build(params[:property]) if signed_in?
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
  end

  def index
    if params[:search].present?
      @properties = Property.search(params)
    else
      @properties = Property.page(params[:page]).per(12)
    end
  end

  def filter
    @search = Property.filter(params[:search])
    render :index
  end

  def rent
    @properties = Property.rent.page(params[:page]).per(12)
    render :index
  end

  def buy
    @properties = Property.buy.page(params[:page]).per(12)
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
  def signed_in
    redirect_to signin_path, notice: 'Please sign in' unless signed_in?
  end

  def correct_user
    redirect_to root_path if current_user.properties.find_by_id(params[:id]).nil?
  end

end