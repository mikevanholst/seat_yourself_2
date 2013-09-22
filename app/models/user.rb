class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :name, :email, :phone, :presence => :true

  has_many :restaurants, through: :reservations
  has_many :reservations
  has_many :reviews
end
