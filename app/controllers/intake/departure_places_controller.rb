module Intake
  class DeparturePlacesController < ApplicationController
    def new
      @departure_place = Intake::DeparturePlace.new
    end

    def create
      @departure_place = Intake::DeparturePlace.new(departure_place_params)
      if @departure_place.valid?
        session[:departure_place] = {
          'departure_place' => @departure_place
        }
        redirect_to new_intake_budget_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def departure_place_params
      params.require(:intake_departure_place).permit(:departure_place)
    end
  end
end
