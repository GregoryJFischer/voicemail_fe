class UsersController < ApplicationController
  def edit
    unless session[:user_id]
      flash[:error] = 'You must be logged in to visit this page'
      redirect_to root_path
    end
  end

  def update
    response = BackendService.update_address(session[:user_id], address_params)
    if response.status == 200
      Rails.cache.delete_matched("representatives-#{session[:user_id]}")
      redirect_to '/dashboard'
    else
      flash[:error] = 'Address invalid; please make sure all fields are filled in and correct.'
      redirect_to '/edit'
    end
  end

  def show
    if session[:user_id]
      @dashboard_facade = UserDashboardFacade.new(session[:user_id])
    else
      flash[:error] = 'You must be logged in to visit this page'
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
