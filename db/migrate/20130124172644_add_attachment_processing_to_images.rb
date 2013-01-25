class AddAttachmentProcessingToImages < ActiveRecord::Migration
  def change
    add_column :images, :attachment_processing, :string
  end
end
