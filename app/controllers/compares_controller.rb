class ComparesController < ApplicationController

  def create
    session[:compare_list] ||= []
    @property = Property.find(params[:id])
    if session[:compare_list].include? @property.id
      redirect_to property_path(@property),
        notice: 'Property listing is already on the compare list'
    elsif session[:compare_list].size == 3
      redirect_to property_path(@property),
        notice:  'You can compare at most 3 listings. Please remove a listing from compare list'
    else
      session[:compare_list] << @property.id
      redirect_to compare_properties_path, notice: 'Successfuly added property for comparison'
    end
  end

  def index
     if session[:compare_list].nil?
       redirect_to properties_path,
     notice: 'You should add a listing to compare list'
     else
       @properties = session[:compare_list].map{|id| Property.find_by_id(id) }
     end
  end

  def update
    session[:compare_list].delete((params[:id]).to_i) unless session[:compare_list].nil?
    redirect_to compare_properties_path
  end
end
