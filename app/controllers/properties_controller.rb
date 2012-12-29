class PropertiesController < ApplicationController
  def new
    @property = Property.new
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
end
