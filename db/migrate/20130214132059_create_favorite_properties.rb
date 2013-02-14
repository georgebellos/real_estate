class CreateFavoriteProperties < ActiveRecord::Migration
  def change
    create_table :favorite_properties do |t|
      t.integer :user_id
      t.integer :property_id

      t.timestamps
    end
  end
end
