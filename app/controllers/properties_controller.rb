class PropertiesController < ApplicationController
  def new
    @property = Property.new
    @property.images.build
  end

  def create
    @property = Property.new(params[:property])
    if @property.save
      redirect_to @property
      flash[:success] = 'You have created a new property'
    else
      render :new
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  def index
    @properties = Property.all
  end

  def edit
    @property = Property.find(params[:id])
  end

  def update
    @property = Property.find(params[:id])
    if @property.update_attributes(params[:property])
      redirect_to property_path
      flash[:success] = 'Property updated'
    else
      render :edit
    end
  end

  def destroy
    @property = Property.find(params[:id])
    @property.destroy
    redirect_to properties_path
    flash[:success] = 'Property destroyed'
  end
end
