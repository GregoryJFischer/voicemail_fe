class WelcomeController < ApplicationController
  def index
    if session[:user_id]
      redirect_to dashboard_path
    end
  end
end