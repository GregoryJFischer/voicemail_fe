class UsersController < ApplicationController
  def edit
  end

  def update
    user = User.find(session[:user_id])
    user.update(
      street_address_1: params[:street_address_1],
      street_address_2: params[:street_address_2],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code]
    )
    redirect_to '/dashboard'
  end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
    else
      flash[:error] = 'You must be logged in'
      redirect_to root_path
    end
  end
end
