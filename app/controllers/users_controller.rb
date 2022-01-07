class UsersController < ApplicationController
  def edit
  end

  def update
    # BackendService.update_address(address_params)
    # if address_params.present?
    #   redirect_to '/dashboard'
    # else
    #   flash[:error] = 'Please fill out all fields'
    # end
    user = User.find(session[:user_id])

    if user.update(address_params)
      redirect_to '/dashboard'
    else
      flash[:error] = 'Please fill out all fields'
    end
  end

  def show
    if session[:user_id]
      @user = User.find(session[:user_id])
      # @representatives = BackendService.representatives(address_params)
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
