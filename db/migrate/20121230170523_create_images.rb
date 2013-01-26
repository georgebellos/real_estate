class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :attachment
      t.references :property

      t.timestamps
    end
    add_index :images, :property_id
  end
end
