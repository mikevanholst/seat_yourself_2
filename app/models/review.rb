class Review < ActiveRecord::Base

validates :content, presence: true

belongs_to :restaurant
belongs_to :user
scope :newest_first, ->  {order("created_at DESC" )}
scope :most_popular_first, -> {order("votes DESC")}
end
