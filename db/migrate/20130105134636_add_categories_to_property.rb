class AddCategoriesToProperty < ActiveRecord::Migration
  def change
    add_column :properties, :category, :string
  end
end
