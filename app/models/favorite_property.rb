class FavoriteProperty < ActiveRecord::Base
  attr_accessible :property_id, :user_id

  belongs_to :user
  belongs_to :property
end
