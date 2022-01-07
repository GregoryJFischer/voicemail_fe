class UsersController < ApplicationController
  def edit
  end

  def update
    BackendService.update_address(address_params, session[:user_id])
    if address_params.present?
      redirect_to '/dashboard'
    else
      flash[:error] = 'Please fill out all fields'
    end
  end

  def show
    if session[:user_id]
      @dashboard_facade = UserDashboardFacade.new(session[:user_id])
    else
      flash[:error] = 'You must be logged in'
      redirect_to root_path
    end
  end

  private

  def address_params
    {
      street_address_1: params[:street_address_1],
      street_address_2: params[:street_address_2],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code]
    }
  end
end
