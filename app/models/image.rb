class Image < ActiveRecord::Base
  belongs_to :property
  attr_accessible :attachment

  mount_uploader :attachment, PictureUploader

  validates :attachment, presence: true
end
