class Route < ApplicationRecord
  belongs_to :user
  has_many :destinations
  has_one :booking
  validates :departure_place, :budget, presence: true
# app/models/route.rb
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user


  def favorite?(current_user)
    !!self.favorites.find{|favorite| favorite.user_id == current_user.id}
  end
end
