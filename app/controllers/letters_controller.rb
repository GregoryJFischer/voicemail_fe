class LettersController < ApplicationController

  def new
  end

  def create
     confirmation = LettersFacade.create_letter(params[:body], session[:user_id])
     if confirmation.has_key?(:message)
       flash[:error] = confirmation[:message]
       redirect_to "/letters/new"
     elsif confirmation[:data][:attributes][:send_date]
       flash[:notice] = 'Your letter has been sent!'
       redirect_to "/dashboard"
     else
       flash[:error] = 'Error and error message not found'
       redirect_to "/letters/new"
     end
  end
end
