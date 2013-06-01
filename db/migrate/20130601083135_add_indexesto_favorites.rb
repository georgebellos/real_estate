class AddIndexestoFavorites < ActiveRecord::Migration
  def change
    add_index :favorite_properties, :user_id
    add_index :favorite_properties, :property_id
  end
end
