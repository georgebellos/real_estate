class User < ActiveRecord::Base
  has_many :properties
  attr_accessible :name, :email, :password, :password_confirmation
  validates :email, presence: true, uniqueness: true,
                    format: { with: /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/ }
  has_secure_password
  validates :password, presence: true,length: { within: 6..32,
                       too_short: "must have at least #{ count } characters",
                       too_long: "must have at most #{ count } characters" }
  validates :password_confirmation, presence: true
end
