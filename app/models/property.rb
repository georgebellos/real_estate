class Property < ActiveRecord::Base
  belongs_to :user
  attr_accessible :area, :price, :status, :street,
                  :street_number, :summary, :year
  validates :area, :price, :status, :street, :street_number, :year, presence: true
  validates :area, :street_number, numericality: true
  validates :year, numericality: { greater_than: 1900 }
  validates :summary, length: { maximum: 400 }
end
