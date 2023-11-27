class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # as a user I can check all my bookings
  # GET /bookings
  def index
    @bookings = bookings.all
    # search by city?
  end

  # as a user I can see more detailes of an specific booking
  # GET /bookings/:booking_id
  def show

  end

  # as a user I can create a new booking
  # GET bookings/new
  def new
    @booking = bookings.new
  end

  # as a user I can make a new booking
  # POST /bookings
  def create
    @booking = booking.new(booking_params)
    @booking.user = current_user
  end

  # DELETE /bookings/:booking_id
  # as a user I can destroy a booking
  def destroy

  end

  private

  def set_booking
    @booking = booking.find(params[:booking_id])
  end

  def booking_params
    params.require(:booking).permit()
  end
end
