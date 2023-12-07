module Intake
  class BudgetsController < ApplicationController
    def new
      @budget = Budget.new
    end

    def create
      @budget = Budget.new(budget_params)

      if @budget.valid?
        full_params = budget_params.merge(session['departure_place'])
        @route = Route.new(full_params)
        @route.user = current_user
        @route.save
        # session.delete('departure_place')
        origin = @route.departure_place
        budget = @route.budget

        debugger
        RouteSuggestionsService.build_route(origin, budget, @route)

        redirect_to route_path(@route)
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def budget_params
      params.require(:intake_budget).permit(:budget)
    end
  end
end
