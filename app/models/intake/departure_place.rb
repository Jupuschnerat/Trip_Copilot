module Intake
  class DeparturePlace
    include ActiveModel::Model
    attr_accessor :departure_place
    validates :departure_place, presence: true
  end
end
