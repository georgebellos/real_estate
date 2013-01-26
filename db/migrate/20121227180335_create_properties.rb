class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :status
      t.integer :price
      t.integer :area
      t.integer :year
      t.string :street
      t.integer :street_number
      t.boolean :moderation, default: false
      t.string :contact_info
      t.text :summary
      t.integer :user_id

      t.timestamps
    end
  end
end
