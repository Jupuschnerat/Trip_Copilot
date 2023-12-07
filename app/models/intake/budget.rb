module Intake
  class Budget
    include ActiveModel::Model
    attr_accessor :budget
    validates :budget, presence: true
  end
end
