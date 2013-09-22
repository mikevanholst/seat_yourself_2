class Restaurant < ActiveRecord::Base
  validates :name, :phone, :address, :presence => true

  has_many :users, through: :reservations
  has_many :reservations
  has_many :reveiws
end
