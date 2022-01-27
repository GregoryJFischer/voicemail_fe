class WelcomeController < ApplicationController
  def index
    redirect_to dashboard_path if session[:user_id]
  end
end
