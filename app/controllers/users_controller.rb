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
      address_line1: params[:address_line1],
      address_line2: params[:address_line2],
      address_city: params[:address_city],
      address_state: params[:address_state],
      address_zip: params[:address_zip]
    }
  end
end
