class Property < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy

  attr_accessible :floor_size, :price, :status, :street, :bedroom, :bathroom,
                  :parking, :street_number, :summary, :year, :images_attributes

  accepts_nested_attributes_for :images, :allow_destroy => true, reject_if: lambda {|a| [:attachment].blank? }

  validates :floor_size, :price, :status, :bedroom, :bathroom, :parking,
            :street, :street_number, :year, presence: true
  validates :floor_size, :bedroom, :bathroom, :parking, :street_number, numericality: true
  validates :year, numericality: { greater_than: 1900 }
  validates :summary, length: { maximum: 400 }
end
