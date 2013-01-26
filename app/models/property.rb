class Property < ActiveRecord::Base
  belongs_to :user
  has_many :images, dependent: :destroy

  attr_accessible :floor_size, :price, :status, :street, :bedroom, :bathroom,
                  :parking, :street_number, :city, :summary, :year,
                  :images_attributes, :category

  accepts_nested_attributes_for :images, :allow_destroy => true,
                                reject_if: lambda {|a| [:attachment].blank? }

  validates :floor_size, :price, :status, :bedroom, :bathroom, :parking,
            :street, :street_number, :city, :year, :category, presence: true
  validates :floor_size, :bedroom, :bathroom, :parking, :street_number, numericality: true
  validates :year, numericality: { greater_than: 1900 }
  validates :summary, length: { maximum: 400 }

  geocoded_by :gmaps4rails_address
  after_validation :geocode

  acts_as_gmappable process_geocoding: false, check_process: false, validations: :false

  def gmaps4rails_address
    "#{self.street} #{self.street_number}, Patra, Greece"
  end
end
