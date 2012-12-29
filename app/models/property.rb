class Property < ActiveRecord::Base
  belongs_to :user
  attr_accessible :floor_size, :price, :status, :street, :bedroom, :bathroom,
                  :parking, :street_number, :summary, :year
  validates :floor_size, :price, :status, :bedroom, :bathroom, :parking,
            :street, :street_number, :year, presence: true
  validates :floor_size, :bedroom, :bathroom, :parking, :street_number, numericality: true
  validates :year, numericality: { greater_than: 1900 }
  validates :summary, length: { maximum: 400 }
end
