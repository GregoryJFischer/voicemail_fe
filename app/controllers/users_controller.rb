class UsersController < ApplicationController
  def edit
    if session[:user_id]
      current_user = BackendService.get_user(session[:user_id])
      @current_address = current_user[:data][:attributes]
    else
      flash[:error] = 'You must be logged in to visit this page'
      redirect_to root_path
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

    if response.status == 200 && address_params.except(:address_line2).values.all? { |address_param| address_param.present?}
      Rails.cache.delete_matched("representatives-#{session[:user_id]}")

      redirect_to '/dashboard'
    else
      flash[:error] = 'Address invalid. Please make sure all fields are filled in and correct.'
      redirect_to '/edit'
    end
  end

  def new
    if session[:user_id]
      redirect_to dashboard_path
    end
  end

  def show
    if session[:user_id] && params[:sent]
      flash[:notice] = 'Your letter has been sent!'
      @user = DashboardFacade.new(session[:user_id]).user
    elsif session[:user_id]
      dashboard = DashboardFacade.new(session[:user_id])
      @user = dashboard.user
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
