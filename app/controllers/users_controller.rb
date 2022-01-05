class UsersController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    google_id = auth_hash['uid']
    email = auth_hash['info']['email']
    token = auth_hash['credentials']['token']

    user = User.find_or_create_by(email: email)
    user.update(google_id: google_id)

    session[:user_id] = user.id
    redirect_to '/dashboard'
  end

  def show
    @user = User.find(session[:user_id])
  end
end
