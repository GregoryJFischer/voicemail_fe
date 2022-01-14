class LettersController < ApplicationController

  def new
    @rep = Representative.new(params)
  end

  def create
    binding.pry
    if params[:commit] == "Preview Letter"
      redirect_to('/fetch_preview', params: request.query_parameters)
    else
     confirmation = LettersFacade.create_letter(params[:body], session[:user_id], rep_params)
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

   def preview
     confirmation = LettersFacade.create_letter(params[:body], session[:user_id], rep_params)
     @preview_url = confirmation[:data][:attributes][:send_date]
   end

private

  def rep_params
    { attributes: {
      name: params[:rep_name],
      address_line1: params[:rep_address_line1],
      address_city: params[:rep_address_city],
      address_state: params[:rep_address_state],
      address_zip: params[:rep_address_zip]
    } }
  end
end
