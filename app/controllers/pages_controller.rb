class PagesController < ApplicationController
  def home
    @properties = Property.recently_created(8)
  end

  def info
  end

end
