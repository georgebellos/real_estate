require 'file_size_validator'

class Image < ActiveRecord::Base
  belongs_to :property
  attr_accessible :attachment, :attachment_cache

  mount_uploader :attachment, PictureUploader
  process_in_background :attachment

  validates :attachment, presence: true, file_size: { maximum: 2.megabytes.to_i }
end
