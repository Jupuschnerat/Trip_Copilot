class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many  :favorites
  has_many :routes
  has_many :bookings
  has_one_attached :image
  validates :birth_date, presence: true
  validates_length_of :password, in: 6..20, on: :create
end
