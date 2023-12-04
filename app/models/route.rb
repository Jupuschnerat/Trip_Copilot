class Route < ApplicationRecord
  belongs_to :user
  has_many :destinations
  has_one :booking
  validates :departure_place, :budget, presence: true
  has_many :favorites

  def favorite?(current_user)
    !!self.favorites.find{|favorite| favorite.user_id == current_user.id}
  end
end
