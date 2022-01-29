class UsersController < ApplicationController
  def edit
    unless session[:user_id]
      flash[:error] = 'You must be logged in to visit this page'
      redirect_to root_path
    else
      current_user = BackendService.get_user(session[:user_id])
      @current_address = current_user[:data][:attributes]
    end
  end

  def create
    user = BackendService.find_or_create_user(user_params)

    unless user[:error]
      session[:token] = user_params[:token]
      session[:user_id] = user[:data][:id].to_i

      redirect_to '/dashboard'
    else
      flash[:error] = user[:error]
      redirect_to '/register'
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

  def new
    if session[:user_id]
      redirect_to dashboard_path
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

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
