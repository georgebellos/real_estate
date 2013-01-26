class RenameAreaFromPropertiesToFloorsize < ActiveRecord::Migration
  def change
    change_table :properties do |t|
      t.rename :area, :floor_size
      t.integer :bathroom
      t.integer :bedroom
      t.integer :parking
    end
  end
end
