class SessionsController < ApplicationController
  def create
    # user = User.find_or_create_by(email: user_params[:email])
    # user.update(google_id: user_params[:google_id], first_name: user_params[:first_name], last_name: user_params[:last_name])
    user = BackendService.find_or_create_user(email: user_params[:email])

    if user.present?
      redirect_to '/dashboard'
    else
      flash[:error] = 'Authentication failed. Please try again.'
    end

    session[:google_token] = user_params[:token]
    session[:user_id] = user.id

    unless user.street_address_1
      redirect_to '/register'
    else
      redirect_to '/dashboard'
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def user_params
    auth_hash = request.env['omniauth.auth']
    {
      google_id: auth_hash['uid'],
      email: auth_hash['info']['email'],
      token: auth_hash['credentials']['token'],
      first_name: auth_hash['info']['first_name'],
      last_name: auth_hash['info']['last_name']
     }
  end
end
