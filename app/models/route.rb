class Route < ApplicationRecord
  belongs_to :user
  has_many :destinations
  has_one :booking
  validates :departure_place, :duration, :budget, presence: true
end