class ProfilesController < ApplicationController
  before_action :set_user, only: :update

  #  PUT    /users
  def update
    if @user.update(user_params)
      flash[:notice] = 'Profile successfully updated!'
      redirect_to dashboard_path
    else
      render '/users'
    end
  end


  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :birth_date, :phone_number, :address)
  end
end
