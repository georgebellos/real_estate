class Property < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  belongs_to :user
  has_many :images, dependent: :destroy
  has_many :favorite_properties
  has_many :favorite_by, through: :favorite_properties, source: :user

  attr_accessible :floor_size, :price, :status, :street, :bedroom, :bathroom,
                  :parking, :street_number, :city, :summary, :year,
                  :images_attributes, :category

  accepts_nested_attributes_for :images, :allow_destroy => true,
                                reject_if: lambda {|a| [:attachment].blank? }

  validates :floor_size, :price, :status, :bedroom, :bathroom, :parking,
            :street, :street_number, :city, :year, :category, presence: true
  validates :floor_size, :bedroom, :bathroom, :parking, :street_number, numericality: true
  validates :year, numericality: { greater_than: 1900 }
  validates :summary, length: { maximum: 800 }

  geocoded_by :gmaps4rails_address
  after_validation :geocode

  acts_as_gmappable process_geocoding: false, check_process: false, validations: :false

  def gmaps4rails_address
    "#{self.street} #{self.street_number}, #{ self.city }, Greece"
  end

  scope :rent, where(status: "Rent")
  scope :buy, where(status: "Buy")

  index_name("#{Rails.env}-search-properties")

  def self.search(params)
    tire.search(load: true, page: params[:page], per_page: 12) do
      query do
        boolean do
          must { string params[:search][:query] } if params[:search][:query].present?

          must { string params[:search][:types].join(" ")
               } if params[:search][:types].present?

          price_from = params[:search][:price_from] if params[:search][:price_from].present?
          price_to = params[:search][:price_to] if params[:search][:price_to].present?
          must { range :price, { gte: price_from, lte: price_to }
               } if price_from || price_to

          bedrooms_from = params[:search][:bedrooms_from] if params[:search][:bedrooms_from].present?
          bedrooms_to = params[:search][:bedrooms_to] if params[:search][:bedrooms_to].present?
          must { range :bedroom, { gte: bedrooms_from, lte: bedrooms_to }
               } if bedrooms_from || bedrooms_to

          floor_size_from = params[:search][:floor_size_from] if params[:search][:floor_size_from].present?
          floor_size_to = params[:search][:floor_size_to] if params[:search][:floor_size_to].present?
          must { range :floor_size, { gte: floor_size_from, lte: floor_size_to }
               } if floor_size_from || floor_size_to
        end
      end

      params[:sort] ||= 'asc'
      sort { by :price, params[:sort] }
    end
  end

  def title
    "#{ status } #{ category }"
  end
end
