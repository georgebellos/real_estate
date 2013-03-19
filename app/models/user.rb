class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me

  has_many :properties, dependent: :destroy
  has_many :favorite_properties
  has_many :favorites, through: :favorite_properties, source: :property
end
