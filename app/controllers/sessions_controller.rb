class SessionsController < ApplicationController
  def create
    user = BackendService.find_or_create_user(user_params)

    if user.present?
      redirect_to '/dashboard'
    else
      flash[:error] = 'Authentication failed. Please try again.'
      redirect_to root_path
    end

    session[:token] = user_params[:token]
    session[:user_id] = user[:data][:id].to_i
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def user_params
    {
      google_id: auth_hash['uid'],
      email: auth_hash['info']['email'],
      token: auth_hash['credentials']['token'],
      name: auth_hash['info']['name']
     }
  end
end
