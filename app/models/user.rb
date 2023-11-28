class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :routes
  has_many :bookings
  validates_length_of :password, in: 6..20, on: :create
  validates :full_name, :phone_number, :birth_date, :email, :password, :address, presence: true
end
